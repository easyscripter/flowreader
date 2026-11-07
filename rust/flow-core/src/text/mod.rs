//! Text processing shared by importers: hyphenation, later normalization.

pub mod hyphen;

pub use hyphen::{HyphenError, Hyphenator};
