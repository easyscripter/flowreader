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

    /// Manual timing, not run in CI: `cargo test --release -p rust_lib_fusionreflow
    /// -- --ignored --nocapture book_meta_on_50mb_book`.
    #[test]
    #[ignore = "manual timing on a ~50 MB book"]
    fn book_meta_on_50mb_book() {
        use flow_core::model::{Block, BlockNode, Book, Inline, Meta, Resource, ResourceId, Style};

        let blocks = (0..50_000)
            .map(|i| BlockNode {
                block: Block::Paragraph {
                    inlines: vec![Inline::Text {
                        text: format!("Paragraph {i}: {}", "word ".repeat(40)),
                        style: Style::default(),
                    }],
                },
                src: None,
            })
            .collect();
        let resources = (0..40)
            .map(|i| Resource {
                id: ResourceId(i),
                mime: "image/png".into(),
                data: vec![0xA5; 1_000_000],
            })
            .collect();
        let book = Book {
            format_version: flow_core::FORMAT_VERSION,
            converter_version: "bench".into(),
            source_hash: "00".repeat(32),
            meta: Meta {
                title: "Big".into(),
                authors: vec![],
                language: None,
                cover: None,
            },
            toc: vec![],
            blocks,
            resources,
        };
        let bytes = flow_core::encode(&book).unwrap();
        println!("encoded size: {} bytes", bytes.len());

        let start = std::time::Instant::now();
        let meta = book_meta(bytes).unwrap();
        let elapsed = start.elapsed();
        println!("book_meta: {elapsed:?}");

        assert_eq!(meta.title, "Big");
        assert!(elapsed.as_secs() < 10, "book_meta took {elapsed:?}");
    }
}
