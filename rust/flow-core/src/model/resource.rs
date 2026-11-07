//! Binary resources (images) referenced from blocks.

use serde::{Deserialize, Serialize};

/// Identifier of a resource within a book.
#[derive(Serialize, Deserialize, Clone, Copy, Debug, PartialEq, Eq, Hash)]
pub struct ResourceId(pub u32);

/// A binary resource, e.g. a PNG image.
#[derive(Serialize, Deserialize, Clone, Debug, PartialEq)]
pub struct Resource {
    /// Identifier referenced by blocks.
    pub id: ResourceId,
    /// MIME type, e.g. `image/png`.
    pub mime: String,
    /// Raw bytes, encoded as a CBOR byte string.
    #[serde(with = "serde_bytes")]
    pub data: Vec<u8>,
}
