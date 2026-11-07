//! Import API exposed to Dart. The source arrives only as a file descriptor.
//!
//! Design: `SourceKind`, `Stage`, `Progress` and `ImportError` are mirrored from
//! `flow_core::import` (small, flat types). `ImportEvent::Done` carries the book
//! as CBOR bytes (`flow_core::encode`) instead of mirroring the whole `Book`
//! tree; Dart decodes lazily or hands the bytes on.

use std::collections::HashMap;
use std::panic::AssertUnwindSafe;
use std::sync::atomic::{AtomicI64, Ordering};
use std::sync::{LazyLock, Mutex};

use flow_core::import::{CancelToken, Converter, ReadSeek, StubConverter};
pub use flow_core::import::{ImportError, Progress, SourceKind, Stage};
use flutter_rust_bridge::frb;

use crate::frb_generated::StreamSink;

#[frb(mirror(SourceKind))]
pub enum _SourceKind {
    Pdf,
    Epub,
    Fb2,
    Fb2Zip,
}

#[frb(mirror(Stage))]
pub enum _Stage {
    Sampling,
    Pages,
    Assembling,
}

#[frb(mirror(Progress))]
pub struct _Progress {
    pub stage: Stage,
    pub done: u32,
    pub total: u32,
}

#[frb(mirror(ImportError))]
pub enum _ImportError {
    NoTextLayer,
    Corrupted(String),
    OutOfMemory,
    Unsupported(SourceKind),
    Cancelled,
}

pub enum ImportEvent {
    Started(i64),
    Progress(Progress),
    /// CBOR-encoded `Book` (`flow_core::encode`).
    Done(Vec<u8>),
    Failed(ImportError),
}

static NEXT_JOB: AtomicI64 = AtomicI64::new(1);
static JOBS: LazyLock<Mutex<HashMap<i64, CancelToken>>> =
    LazyLock::new(|| Mutex::new(HashMap::new()));

/// Chooses the converter for a source kind. The `pdf` feature will wire in
/// `flow_pdf::PdfConverter` (plan 3); for now it is always the stub.
pub(crate) fn converter_for(_kind: SourceKind) -> Box<dyn Converter> {
    Box::new(StubConverter)
}

#[cfg(unix)]
fn source_from_fd(fd: i32) -> Result<Box<dyn ReadSeek>, ImportError> {
    use std::os::unix::io::FromRawFd;
    if fd < 0 {
        return Err(ImportError::Corrupted("invalid file descriptor".into()));
    }
    // SAFETY: the caller transfers ownership of `fd`; we close it on drop.
    Ok(Box::new(unsafe { std::fs::File::from_raw_fd(fd) }))
}

#[cfg(not(unix))]
fn source_from_fd(_fd: i32) -> Result<Box<dyn ReadSeek>, ImportError> {
    Err(ImportError::Corrupted(
        "file descriptors are unsupported on this platform".into(),
    ))
}

/// Runs one import job to completion: always removes the registry entry and
/// emits exactly one terminal event (`Done` or `Failed`), even if the
/// converter panics.
fn run_job(
    job_id: i64,
    converter: &dyn Converter,
    source: Result<Box<dyn ReadSeek>, ImportError>,
    kind: SourceKind,
    token: &CancelToken,
    emit: &mut dyn FnMut(ImportEvent),
) {
    let result = match source {
        Err(e) => Err(e),
        Ok(mut src) => {
            let outcome = std::panic::catch_unwind(AssertUnwindSafe(|| {
                let mut on_progress = |p: Progress| emit(ImportEvent::Progress(p));
                converter.convert(&mut *src, kind, &mut on_progress, token)
            }));
            match outcome {
                Ok(r) => r.and_then(|book| {
                    flow_core::encode(&book)
                        .map_err(|e| ImportError::Corrupted(format!("cannot encode book: {e}")))
                }),
                Err(_) => Err(ImportError::Corrupted(
                    "internal error: converter panicked".into(),
                )),
            }
        }
    };
    JOBS.lock()
        .unwrap_or_else(|e| e.into_inner())
        .remove(&job_id);
    emit(match result {
        Ok(bytes) => ImportEvent::Done(bytes),
        Err(e) => ImportEvent::Failed(e),
    });
}

/// Starts an import on a background thread. Rust takes ownership of `fd` and
/// closes it. The first event is `Started(jobId)`; the stream ends after
/// `Done` or `Failed`.
pub fn import_book(fd: i32, kind: SourceKind, sink: StreamSink<ImportEvent>) {
    let job_id = NEXT_JOB.fetch_add(1, Ordering::SeqCst);
    let token = CancelToken::new();
    JOBS.lock()
        .unwrap_or_else(|e| e.into_inner())
        .insert(job_id, token.clone());
    // Take ownership of the fd before spawning so it is closed on every path.
    let source = source_from_fd(fd);
    let _ = sink.add(ImportEvent::Started(job_id));
    std::thread::spawn(move || {
        let converter = converter_for(kind);
        run_job(job_id, &*converter, source, kind, &token, &mut |e| {
            let _ = sink.add(e);
        });
    });
}

/// Requests cancellation of a running import. Unknown ids are ignored.
pub fn cancel_import(job_id: i64) {
    if let Some(t) = JOBS.lock().unwrap_or_else(|e| e.into_inner()).get(&job_id) {
        t.cancel();
    }
}

fn open_fd_guarded(path: &str, debug: bool) -> Result<i32, String> {
    if !debug {
        return Err("debug_open_fd is only available in debug builds".into());
    }
    #[cfg(unix)]
    {
        use std::os::unix::io::IntoRawFd;
        std::fs::File::open(path)
            .map(|f| f.into_raw_fd())
            .map_err(|e| e.to_string())
    }
    #[cfg(not(unix))]
    {
        let _ = path;
        Err("file descriptors are unsupported on this platform".into())
    }
}

/// TEST-ONLY: opens `path` read-only and returns the raw fd (ownership passes
/// to the caller, e.g. to `import_book`). Refuses (without touching the
/// filesystem) in release builds, so the app never opens sources by path.
pub fn debug_open_fd(path: String) -> Result<i32, String> {
    open_fd_guarded(&path, cfg!(debug_assertions))
}

#[cfg(test)]
mod tests {
    use super::*;
    use flow_core::model::Book;

    struct Panicker;
    impl Converter for Panicker {
        fn convert(
            &self,
            _: &mut dyn ReadSeek,
            _: SourceKind,
            _: &mut dyn FnMut(Progress),
            _: &CancelToken,
        ) -> Result<Book, ImportError> {
            panic!("boom");
        }
    }

    #[test]
    fn panic_yields_single_failed_and_cleans_registry() {
        let id = 9_000_001;
        let token = CancelToken::new();
        JOBS.lock().unwrap().insert(id, token.clone());
        let mut events = Vec::new();
        let src: Result<Box<dyn ReadSeek>, ImportError> =
            Ok(Box::new(std::io::Cursor::new(Vec::<u8>::new())));
        run_job(id, &Panicker, src, SourceKind::Pdf, &token, &mut |e| {
            events.push(e)
        });
        assert_eq!(events.len(), 1);
        assert!(matches!(
            &events[0],
            ImportEvent::Failed(ImportError::Corrupted(m)) if m.contains("panicked")
        ));
        assert!(!JOBS.lock().unwrap().contains_key(&id));
    }

    #[test]
    fn debug_guard_refuses_in_release() {
        assert!(open_fd_guarded("/nonexistent/x", false).is_err());
        assert!(open_fd_guarded("/nonexistent/x", true).is_err()); // reaches fs, not found
        let e = open_fd_guarded("/nonexistent/x", false).unwrap_err();
        assert!(e.contains("debug builds"));
    }

    #[cfg(unix)]
    #[test]
    fn negative_fd_rejected() {
        assert!(matches!(source_from_fd(-1), Err(ImportError::Corrupted(_))));
    }
}
