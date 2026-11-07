//! Import of source files into the block format.
//!
//! `api` defines the contract every importer implements; [`StubConverter`]
//! is the placeholder used when no real converter is linked in.

mod api;
mod stub;

pub use api::{CancelToken, Converter, ImportError, Progress, ReadSeek, SourceKind, Stage};
pub use stub::StubConverter;
