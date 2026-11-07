//! Import API exposed to Dart. The source arrives only as a file descriptor.
//!
//! Design: `SourceKind`, `Stage`, `Progress` and `ImportError` are mirrored from
//! `flow_core::import` (small, flat types). `ImportEvent::Done` carries the book
//! as CBOR bytes (`flow_core::encode`) instead of mirroring the whole `Book`
//! tree; Dart decodes lazily or hands the bytes on.

use std::collections::HashMap;
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
    // SAFETY: the caller transfers ownership of `fd`; we close it on drop.
    Ok(Box::new(unsafe { std::fs::File::from_raw_fd(fd) }))
}

#[cfg(not(unix))]
fn source_from_fd(_fd: i32) -> Result<Box<dyn ReadSeek>, ImportError> {
    Err(ImportError::Corrupted("file descriptors are unsupported on this platform".into()))
}

/// Starts an import on a background thread. Rust takes ownership of `fd` and
/// closes it. The first event is `Started(jobId)`; the stream ends after
/// `Done` or `Failed`.
pub fn import_book(fd: i32, kind: SourceKind, sink: StreamSink<ImportEvent>) {
    let job_id = NEXT_JOB.fetch_add(1, Ordering::SeqCst);
    let token = CancelToken::new();
    JOBS.lock().unwrap().insert(job_id, token.clone());
    // Take ownership of the fd before spawning so it is closed on every path.
    let source = source_from_fd(fd);
    let _ = sink.add(ImportEvent::Started(job_id));
    std::thread::spawn(move || {
        let result = source.and_then(|mut src| {
            let mut on_progress = |p: Progress| {
                let _ = sink.add(ImportEvent::Progress(p));
            };
            converter_for(kind)
                .convert(&mut *src, kind, &mut on_progress, &token)
                .map(|book| flow_core::encode(&book))
        });
        JOBS.lock().unwrap().remove(&job_id);
        let _ = sink.add(match result {
            Ok(bytes) => ImportEvent::Done(bytes),
            Err(e) => ImportEvent::Failed(e),
        });
    });
}

/// Requests cancellation of a running import. Unknown ids are ignored.
pub fn cancel_import(job_id: i64) {
    if let Some(t) = JOBS.lock().unwrap().get(&job_id) {
        t.cancel();
    }
}

/// TEST-ONLY: opens `path` read-only and returns the raw fd (ownership passes
/// to the caller, e.g. to `import_book`).
pub fn debug_open_fd(path: String) -> Result<i32, String> {
    #[cfg(unix)]
    {
        use std::os::unix::io::IntoRawFd;
        std::fs::File::open(&path).map(|f| f.into_raw_fd()).map_err(|e| e.to_string())
    }
    #[cfg(not(unix))]
    {
        let _ = path;
        Err("file descriptors are unsupported on this platform".into())
    }
}
