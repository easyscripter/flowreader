//! Manual timing of `book_meta` on a ~50 MB book (spec 3.1, Review Focus 3).
//! Ignored by default; it lives in `tests/` so it does not count toward coverage.
//! Run: `cargo test --release -p rust_lib_fusionreflow --test book_meta_large
//! -- --ignored --nocapture`.

use flow_core::model::{Block, BlockNode, Book, Inline, Meta, Resource, ResourceId, Style};
use rust_lib_fusionreflow::api::book::book_meta;

#[test]
#[ignore = "manual timing on a ~50 MB book"]
fn book_meta_on_50mb_book() {
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
