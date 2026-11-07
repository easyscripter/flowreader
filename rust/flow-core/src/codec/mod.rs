//! CBOR encoding of [`Book`](crate::model::Book) with a format-version check.

use serde::Deserialize;

use crate::model::Book;
use crate::FORMAT_VERSION;

/// Why a book could not be encoded or decoded.
#[derive(Debug, Clone, PartialEq, Eq, thiserror::Error)]
pub enum FormatError {
    /// The data was written by a newer format version than this build supports.
    #[error("unsupported format version {0}")]
    UnsupportedFormatVersion(u32),
    /// The data is not a valid book.
    #[error("corrupt book data: {0}")]
    Corrupt(String),
    /// The book could not be serialized.
    #[error("cannot encode book: {0}")]
    Encode(String),
}

/// Serializes `book` to CBOR.
///
/// # Errors
/// Returns [`FormatError::Encode`] if serialization fails.
pub fn encode(book: &Book) -> Result<Vec<u8>, FormatError> {
    let mut out = Vec::new();
    ciborium::into_writer(book, &mut out).map_err(|e| FormatError::Encode(e.to_string()))?;
    Ok(out)
}

/// Deserializes a book from CBOR, refusing books from a newer format version.
///
/// # Errors
/// Returns [`FormatError::UnsupportedFormatVersion`] for newer formats and
/// [`FormatError::Corrupt`] for invalid data.
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
