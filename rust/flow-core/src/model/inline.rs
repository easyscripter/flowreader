//! Inline content inside blocks: styled text, links, note references, images.

use serde::{Deserialize, Serialize};

use super::ResourceId;

/// A run of inline content.
#[derive(Serialize, Deserialize, Clone, Debug, PartialEq)]
pub enum Inline {
    /// Styled text.
    Text {
        /// The text (may contain soft hyphens U+00AD).
        text: String,
        /// Character style.
        style: Style,
    },
    /// Hyperlink around other inlines.
    Link {
        /// Link destination.
        target: LinkTarget,
        /// Linked content.
        inlines: Vec<Inline>,
    },
    /// Reference to a footnote.
    NoteRef {
        /// Id of the `Block::Footnote`.
        id: String,
        /// Label shown in the text (e.g. "1").
        label: String,
    },
    /// Small image inside a line (e.g. an inline formula).
    Image {
        /// Image resource.
        res: ResourceId,
        /// Height relative to the font size.
        height_em: f32,
    },
}

/// Character style of a text run.
#[derive(Serialize, Deserialize, Clone, Debug, PartialEq, Default)]
pub struct Style {
    /// Bold.
    pub bold: bool,
    /// Italic.
    pub italic: bool,
    /// Monospace inline code.
    pub code: bool,
    /// Superscript / subscript.
    pub script: Script,
}

/// Vertical position of a text run.
#[derive(Serialize, Deserialize, Clone, Copy, Debug, PartialEq, Eq, Default)]
pub enum Script {
    /// Baseline.
    #[default]
    Normal,
    /// Superscript.
    Sup,
    /// Subscript.
    Sub,
}

/// Destination of a link.
#[derive(Serialize, Deserialize, Clone, Debug, PartialEq)]
pub enum LinkTarget {
    /// Index into `Book::blocks`.
    Internal(usize),
    /// External URL.
    External(String),
}
