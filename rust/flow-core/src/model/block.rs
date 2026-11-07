//! Block-level content: headings, paragraphs, lists, code, figures, tables, notes.

use serde::{Deserialize, Serialize};

use super::{Inline, ResourceId};

/// A block together with where it came from in the source document.
#[derive(Serialize, Deserialize, Clone, Debug, PartialEq)]
pub struct BlockNode {
    /// The block itself.
    pub block: Block,
    /// Position in the source (PDF page and rectangle), if known.
    pub src: Option<SourceRef>,
}

/// A block of content.
#[derive(Serialize, Deserialize, Clone, Debug, PartialEq)]
pub enum Block {
    /// Section heading.
    Heading {
        /// Level 1–4, 1 = chapter.
        level: u8,
        /// Heading text.
        inlines: Vec<Inline>,
    },
    /// Paragraph of running text.
    Paragraph {
        /// Paragraph text.
        inlines: Vec<Inline>,
    },
    /// List item.
    ListItem {
        /// Bullet or number.
        marker: ListMarker,
        /// Nesting depth, 0 = top level.
        depth: u8,
        /// Item text.
        inlines: Vec<Inline>,
    },
    /// Block quotation.
    Quote {
        /// Quoted blocks.
        blocks: Vec<BlockNode>,
    },
    /// Preformatted code; indentation is kept in the lines.
    Code {
        /// Source lines without trailing newlines.
        lines: Vec<String>,
    },
    /// Figure rendered as an image, with an optional caption.
    Figure {
        /// Image resource.
        image: ResourceId,
        /// Caption text (may be empty).
        caption: Vec<Inline>,
    },
    /// Display formula rendered as an image.
    Formula {
        /// Image resource.
        image: ResourceId,
    },
    /// Simple table; complex tables become `Figure`.
    Table(Table),
    /// Footnote body, referenced by `Inline::NoteRef`.
    Footnote {
        /// Footnote id used by references.
        id: String,
        /// Footnote content.
        blocks: Vec<BlockNode>,
    },
    /// Thematic break.
    Separator,
    /// Whole page shown as an image (fixed-layout EPUB).
    FixedPage {
        /// Page image resource.
        image: ResourceId,
    },
}

/// List item marker.
#[derive(Serialize, Deserialize, Clone, Copy, Debug, PartialEq, Eq)]
pub enum ListMarker {
    /// Unordered item.
    Bullet,
    /// Ordered item with its number.
    Number(u32),
}

/// Simple table; complex tables are rendered as `Block::Figure`.
#[derive(Serialize, Deserialize, Clone, Debug, PartialEq)]
pub struct Table {
    /// Rows of cells; each cell is a run of inlines.
    pub rows: Vec<Vec<Vec<Inline>>>,
}

/// Where a block came from in the source document.
#[derive(Serialize, Deserialize, Clone, Copy, Debug, PartialEq)]
pub struct SourceRef {
    /// Zero-based page index.
    pub page: u32,
    /// `[x0, y0, x1, y1]` in points from the top-left of the page.
    pub rect: [f32; 4],
}
