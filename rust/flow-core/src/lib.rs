//! FlowReader core: block format, hyphenation and import logic.

pub mod codec;
pub mod hyphen;
pub mod import;
pub mod model;

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
