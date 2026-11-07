//! Block format v1: the book representation exchanged between importers,
//! the PDF converter and the renderer.

use serde::{Deserialize, Serialize};

#[derive(Serialize, Deserialize, Clone, Debug, PartialEq)]
pub struct Book {
    pub format_version: u32,
    pub converter_version: String,
    /// SHA-256 of the source file, hex encoded.
    pub source_hash: String,
    pub meta: Meta,
    pub toc: Vec<TocEntry>,
    pub blocks: Vec<BlockNode>,
    pub resources: Vec<Resource>,
}

#[derive(Serialize, Deserialize, Clone, Debug, PartialEq)]
pub struct BlockNode {
    pub block: Block,
    pub src: Option<SourceRef>,
}

#[derive(Serialize, Deserialize, Clone, Debug, PartialEq)]
pub struct Meta {
    pub title: String,
    pub authors: Vec<String>,
    pub language: Option<String>,
    pub cover: Option<ResourceId>,
}

#[derive(Serialize, Deserialize, Clone, Debug, PartialEq)]
pub struct TocEntry {
    pub level: u8,
    pub title: String,
    /// Index into `Book::blocks`.
    pub block: usize,
}

#[derive(Serialize, Deserialize, Clone, Debug, PartialEq)]
pub enum Block {
    Heading { level: u8, inlines: Vec<Inline> },
    Paragraph { inlines: Vec<Inline> },
    ListItem { marker: ListMarker, depth: u8, inlines: Vec<Inline> },
    Quote { blocks: Vec<BlockNode> },
    Code { lines: Vec<String> },
    Figure { image: ResourceId, caption: Vec<Inline> },
    Formula { image: ResourceId },
    Table(Table),
    Footnote { id: String, blocks: Vec<BlockNode> },
    Separator,
    FixedPage { image: ResourceId },
}

#[derive(Serialize, Deserialize, Clone, Debug, PartialEq)]
pub enum Inline {
    Text { text: String, style: Style },
    Link { target: LinkTarget, inlines: Vec<Inline> },
    NoteRef { id: String, label: String },
    Image { res: ResourceId, height_em: f32 },
}

#[derive(Serialize, Deserialize, Clone, Debug, PartialEq, Default)]
pub struct Style {
    pub bold: bool,
    pub italic: bool,
    pub code: bool,
    pub script: Script,
}

#[derive(Serialize, Deserialize, Clone, Copy, Debug, PartialEq, Eq, Default)]
pub enum Script {
    #[default]
    Normal,
    Sup,
    Sub,
}

#[derive(Serialize, Deserialize, Clone, Copy, Debug, PartialEq, Eq)]
pub enum ListMarker {
    Bullet,
    Number(u32),
}

#[derive(Serialize, Deserialize, Clone, Debug, PartialEq)]
pub enum LinkTarget {
    /// Index into `Book::blocks`.
    Internal(usize),
    External(String),
}

/// Simple table; complex tables are rendered as `Block::Figure`.
#[derive(Serialize, Deserialize, Clone, Debug, PartialEq)]
pub struct Table {
    pub rows: Vec<Vec<Vec<Inline>>>,
}

#[derive(Serialize, Deserialize, Clone, Copy, Debug, PartialEq)]
pub struct SourceRef {
    pub page: u32,
    pub rect: [f32; 4],
}

#[derive(Serialize, Deserialize, Clone, Copy, Debug, PartialEq, Eq, Hash)]
pub struct ResourceId(pub u32);

#[derive(Serialize, Deserialize, Clone, Debug, PartialEq)]
pub struct Resource {
    pub id: ResourceId,
    pub mime: String,
    pub data: Vec<u8>,
}
