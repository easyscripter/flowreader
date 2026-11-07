//! Import contract: source kinds, progress, errors, cancellation, and the
//! `Converter` trait. Real converters live elsewhere; `StubConverter` is a
//! placeholder that reports progress and then returns `Unsupported`.

use std::io::{Read, Seek};
use std::sync::atomic::{AtomicBool, Ordering};
use std::sync::Arc;
use std::time::Duration;

use crate::model::Book;

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum SourceKind {
    Pdf,
    Epub,
    Fb2,
    Fb2Zip,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Stage {
    Sampling,
    Pages,
    Assembling,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub struct Progress {
    pub stage: Stage,
    pub done: u32,
    pub total: u32,
}

#[derive(Debug, Clone, PartialEq, Eq, thiserror::Error)]
pub enum ImportError {
    #[error("no text layer")]
    NoTextLayer,
    #[error("corrupted source: {0}")]
    Corrupted(String),
    #[error("out of memory")]
    OutOfMemory,
    #[error("unsupported source kind: {0:?}")]
    Unsupported(SourceKind),
    #[error("cancelled")]
    Cancelled,
}

/// Cloneable cancellation flag shared between the importer and its caller.
#[derive(Debug, Clone, Default)]
pub struct CancelToken(Arc<AtomicBool>);

impl CancelToken {
    pub fn new() -> Self {
        Self::default()
    }
    pub fn cancel(&self) {
        self.0.store(true, Ordering::SeqCst);
    }
    pub fn is_cancelled(&self) -> bool {
        self.0.load(Ordering::SeqCst)
    }
}

pub trait ReadSeek: Read + Seek + Send {}
impl<T: Read + Seek + Send> ReadSeek for T {}

pub trait Converter: Send + Sync {
    fn convert(
        &self,
        src: &mut dyn ReadSeek,
        kind: SourceKind,
        progress: &mut dyn FnMut(Progress),
        cancel: &CancelToken,
    ) -> Result<Book, ImportError>;
}

/// Emits three `Pages` progress events, then `Err(Unsupported(kind))`.
/// Cancellation is checked before each event.
pub struct StubConverter;

impl Converter for StubConverter {
    fn convert(
        &self,
        _src: &mut dyn ReadSeek,
        kind: SourceKind,
        progress: &mut dyn FnMut(Progress),
        cancel: &CancelToken,
    ) -> Result<Book, ImportError> {
        for done in 1..=3 {
            if cancel.is_cancelled() {
                return Err(ImportError::Cancelled);
            }
            progress(Progress { stage: Stage::Pages, done, total: 3 });
            // Stub-only pacing so callers can deterministically cancel mid-run.
            std::thread::sleep(Duration::from_millis(50));
        }
        if cancel.is_cancelled() {
            return Err(ImportError::Cancelled);
        }
        Err(ImportError::Unsupported(kind))
    }
}
