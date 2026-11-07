//! Import contract: source kinds, progress, errors, cancellation and the
//! [`Converter`] trait implemented by every importer.

use std::io::{Read, Seek};
use std::sync::atomic::{AtomicBool, Ordering};
use std::sync::Arc;

use crate::model::Book;

/// Kind of source file being imported.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum SourceKind {
    /// PDF document.
    Pdf,
    /// EPUB 2/3.
    Epub,
    /// FictionBook 2 XML.
    Fb2,
    /// FictionBook 2 inside a ZIP archive.
    Fb2Zip,
}

/// Stage of an import, for progress reporting.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Stage {
    /// Learning the book's styles from a sample of pages.
    Sampling,
    /// Processing pages / chapters.
    Pages,
    /// Assembling the final book.
    Assembling,
}

/// Progress of an import.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub struct Progress {
    /// Current stage.
    pub stage: Stage,
    /// Units done in this stage.
    pub done: u32,
    /// Total units in this stage.
    pub total: u32,
}

/// Why an import failed.
#[derive(Debug, Clone, PartialEq, Eq, thiserror::Error)]
pub enum ImportError {
    /// The PDF has no text layer (a scan without OCR).
    #[error("no text layer")]
    NoTextLayer,
    /// The source is damaged or not what it claims to be.
    #[error("corrupted source: {0}")]
    Corrupted(String),
    /// The device ran out of memory.
    #[error("out of memory")]
    OutOfMemory,
    /// This build cannot import this kind of source.
    #[error("unsupported source kind: {0:?}")]
    Unsupported(SourceKind),
    /// The import was cancelled by the caller.
    #[error("cancelled")]
    Cancelled,
}

/// Cloneable cancellation flag shared between the importer and its caller.
#[derive(Debug, Clone, Default)]
pub struct CancelToken(Arc<AtomicBool>);

impl CancelToken {
    /// Creates a token that is not cancelled.
    pub fn new() -> Self {
        Self::default()
    }

    /// Requests cancellation; importers stop at their next check.
    pub fn cancel(&self) {
        self.0.store(true, Ordering::SeqCst);
    }

    /// Returns `true` once [`cancel`](Self::cancel) has been called.
    pub fn is_cancelled(&self) -> bool {
        self.0.load(Ordering::SeqCst)
    }
}

/// A readable, seekable source that can be moved to another thread.
pub trait ReadSeek: Read + Seek + Send {}
impl<T: Read + Seek + Send> ReadSeek for T {}

/// Converts a source file into a [`Book`].
pub trait Converter: Send + Sync {
    /// Converts `src` of the given `kind`, reporting `progress` and checking
    /// `cancel` regularly.
    ///
    /// # Errors
    /// Returns [`ImportError`] when the source cannot be converted or the
    /// import is cancelled.
    fn convert(
        &self,
        src: &mut dyn ReadSeek,
        kind: SourceKind,
        progress: &mut dyn FnMut(Progress),
        cancel: &CancelToken,
    ) -> Result<Book, ImportError>;
}
