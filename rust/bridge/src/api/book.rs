//! Library catalog API exposed to Dart: bibliographic data of an encoded book.

pub use flow_core::FormatError;
use flutter_rust_bridge::frb;

#[frb(mirror(FormatError))]
pub enum _FormatError {
    UnsupportedFormatVersion(u32),
    Corrupt(String),
    Encode(String),
}

/// Bibliographic data of an encoded book, for the library catalog.
pub struct BookMeta {
    pub title: String,
    pub authors: Vec<String>,
    pub language: Option<String>,
    pub source_hash: String,
    pub converter_version: String,
}

/// Decodes CBOR `bytes` (`flow_core::encode`) and returns its catalog data.
/// Errors: the `flow_core::decode` error as is (bad CBOR, unsupported `format_version`).
pub fn book_meta(bytes: Vec<u8>) -> Result<BookMeta, FormatError> {
    let book = flow_core::decode(&bytes)?;
    Ok(BookMeta {
        title: book.meta.title,
        authors: book.meta.authors,
        language: book.meta.language,
        source_hash: book.source_hash,
        converter_version: book.converter_version,
    })
}

#[cfg(test)]
mod tests {
    use super::*;

    const FIXTURE: &[u8] = include_bytes!("../../../flow-core/tests/fixtures/book_v1.cbor");

    // Expected values are `sample_book()` from `flow-core/tests/model.rs`, which
    // wrote `book_v1.cbor`; that helper is not reachable from this crate.
    #[test]
    fn book_meta_reads_fixture() {
        let meta = book_meta(FIXTURE.to_vec()).unwrap();
        assert_eq!(meta.title, "Title");
        assert_eq!(meta.authors, vec!["A", "B"]);
        assert_eq!(meta.language.as_deref(), Some("ru"));
        assert_eq!(meta.source_hash, "ab".repeat(32));
        assert_eq!(meta.converter_version, "0.1.0");
    }

    #[test]
    fn book_meta_rejects_garbage() {
        assert!(matches!(
            book_meta(vec![0xFF, 0x00]),
            Err(FormatError::Corrupt(_))
        ));
    }

    #[test]
    fn book_meta_rejects_empty() {
        assert!(matches!(book_meta(vec![]), Err(FormatError::Corrupt(_))));
    }
}
