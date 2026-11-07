use flow_core::codec::{decode, encode};
use flow_core::model::*;
use flow_core::{FormatError, FORMAT_VERSION};

fn text(s: &str) -> Inline {
    Inline::Text { text: s.into(), style: Style::default() }
}

fn sample_book() -> Book {
    let styled = Inline::Text {
        text: "x".into(),
        style: Style { bold: true, italic: true, code: true, script: Script::Sup },
    };
    let sub = Inline::Text {
        text: "2".into(),
        style: Style { script: Script::Sub, ..Style::default() },
    };
    let inlines = vec![
        text("hello"),
        styled,
        sub,
        Inline::Link { target: LinkTarget::Internal(3), inlines: vec![text("in")] },
        Inline::Link { target: LinkTarget::External("https://e.org".into()), inlines: vec![text("out")] },
        Inline::NoteRef { id: "n1".into(), label: "1".into() },
        Inline::Image { res: ResourceId(1), height_em: 1.5 },
    ];
    let src = Some(SourceRef { page: 4, rect: [1.0, 2.0, 3.5, 4.25] });
    let node = |block| BlockNode { block, src: None };
    let blocks = vec![
        BlockNode { block: Block::Heading { level: 1, inlines: vec![text("T")] }, src },
        node(Block::Paragraph { inlines }),
        node(Block::ListItem { marker: ListMarker::Bullet, depth: 0, inlines: vec![text("a")] }),
        node(Block::ListItem { marker: ListMarker::Number(7), depth: 1, inlines: vec![text("b")] }),
        node(Block::Quote { blocks: vec![node(Block::Paragraph { inlines: vec![text("q")] })] }),
        node(Block::Code { lines: vec!["fn a() {}".into(), "".into()] }),
        node(Block::Figure { image: ResourceId(0), caption: vec![text("cap")] }),
        node(Block::Formula { image: ResourceId(1) }),
        node(Block::Table(Table { rows: vec![vec![vec![text("c1")], vec![text("c2")]]] })),
        node(Block::Footnote { id: "n1".into(), blocks: vec![node(Block::Separator)] }),
        node(Block::Separator),
        node(Block::FixedPage { image: ResourceId(0) }),
    ];
    Book {
        format_version: FORMAT_VERSION,
        converter_version: "0.1.0".into(),
        source_hash: "ab".repeat(32),
        meta: Meta {
            title: "Title".into(),
            authors: vec!["A".into(), "B".into()],
            language: Some("ru".into()),
            cover: Some(ResourceId(0)),
        },
        toc: vec![TocEntry { level: 1, title: "T".into(), block: 0 }],
        blocks,
        resources: vec![
            Resource { id: ResourceId(0), mime: "image/png".into(), data: vec![0, 1, 2, 255] },
            Resource { id: ResourceId(1), mime: "image/jpeg".into(), data: vec![] },
        ],
    }
}

#[test]
fn roundtrip_all_variants() {
    let book = sample_book();
    let bytes = encode(&book);
    assert_eq!(decode(&bytes).unwrap(), book);
}

#[test]
fn rejects_newer_format() {
    let mut book = sample_book();
    book.format_version = FORMAT_VERSION + 1;
    let err = decode(&encode(&book)).unwrap_err();
    assert!(matches!(err, FormatError::UnsupportedFormatVersion(2)));
}

#[test]
fn newer_format_rejected_even_if_body_unknown() {
    // Future version with a different body shape must still report the version.
    #[derive(serde::Serialize)]
    struct Future { format_version: u32, brand_new: Vec<u8> }
    let mut out = Vec::new();
    ciborium::into_writer(&Future { format_version: 9, brand_new: vec![1] }, &mut out).unwrap();
    assert!(matches!(decode(&out), Err(FormatError::UnsupportedFormatVersion(9))));
}

#[test]
fn garbage_is_corrupt() {
    assert!(matches!(decode(b"xyz"), Err(FormatError::Corrupt(_))));
}
