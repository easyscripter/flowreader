//! FlowReader core: block format, hyphenation and import logic.

/// Version of the on-disk block format.
pub const FORMAT_VERSION: u32 = 1;

#[cfg(test)]
mod tests {
    #[test]
    fn version_is_one() {
        assert_eq!(crate::FORMAT_VERSION, 1);
    }
}
