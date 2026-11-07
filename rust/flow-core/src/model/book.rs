//! The book as a whole: metadata, table of contents, blocks and resources.

use serde::{Deserialize, Serialize};

use super::{BlockNode, Resource, ResourceId};

/// A converted or imported book.
#[derive(Serialize, Deserialize, Clone, Debug, PartialEq)]
pub struct Book {
    /// Version of the block format the book was written with.
    pub format_version: u32,
    /// Version of the converter / importer that produced the book.
    pub converter_version: String,
    /// SHA-256 of the source file, hex encoded.
    pub source_hash: String,
    /// Title, authors, language, cover.
    pub meta: Meta,
    /// Table of contents.
    pub toc: Vec<TocEntry>,
    /// Content blocks in reading order.
    pub blocks: Vec<BlockNode>,
    /// Images and other binary resources referenced by blocks.
    pub resources: Vec<Resource>,
}

/// Bibliographic metadata.
#[derive(Serialize, Deserialize, Clone, Debug, PartialEq)]
pub struct Meta {
    /// Book title.
    pub title: String,
    /// Authors in display order.
    pub authors: Vec<String>,
    /// BCP 47 language tag, if known.
    pub language: Option<String>,
    /// Cover image, if any.
    pub cover: Option<ResourceId>,
}

/// One entry of the table of contents.
#[derive(Serialize, Deserialize, Clone, Debug, PartialEq)]
pub struct TocEntry {
    /// Nesting level, 1 = chapter.
    pub level: u8,
    /// Entry title.
    pub title: String,
    /// Index into `Book::blocks`.
    pub block: usize,
}
