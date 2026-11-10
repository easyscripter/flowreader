//! FusionReflow core: block format, CBOR codec, text processing and the import
//! contract shared by the reader and the PDF converter.
#![deny(missing_docs)]

pub mod codec;
pub mod import;
pub mod model;
pub mod text;

pub use codec::{decode, encode, FormatError};

/// Version of the on-disk block format.
pub const FORMAT_VERSION: u32 = 1;

#[cfg(test)]
mod tests {
    #[test]
    fn version_is_one() {
        assert_eq!(crate::FORMAT_VERSION, 1);
    }
}
