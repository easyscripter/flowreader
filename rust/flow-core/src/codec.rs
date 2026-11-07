//! CBOR encoding of [`Book`](crate::model::Book).

use crate::model::Book;
use crate::FORMAT_VERSION;
use serde::Deserialize;

#[derive(Debug, Clone, PartialEq, Eq, thiserror::Error)]
pub enum FormatError {
    #[error("unsupported format version {0}")]
    UnsupportedFormatVersion(u32),
    #[error("corrupt book data: {0}")]
    Corrupt(String),
}

pub fn encode(book: &Book) -> Vec<u8> {
    let mut out = Vec::new();
    ciborium::into_writer(book, &mut out).expect("serializing to Vec cannot fail");
    out
}

pub fn decode(bytes: &[u8]) -> Result<Book, FormatError> {
    #[derive(Deserialize)]
    struct Header {
        format_version: u32,
    }
    let header: Header =
        ciborium::from_reader(bytes).map_err(|e| FormatError::Corrupt(e.to_string()))?;
    if header.format_version > FORMAT_VERSION {
        return Err(FormatError::UnsupportedFormatVersion(header.format_version));
    }
    ciborium::from_reader(bytes).map_err(|e| FormatError::Corrupt(e.to_string()))
}
