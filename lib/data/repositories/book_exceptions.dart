/// The bytes passed to `BookRepository.add` are not a readable book.
class BookFormatException implements Exception {
  /// Creates the exception with the converter's [message].
  const new(this.message);

  /// Text of the underlying format error.
  final String message;

  @override
  String toString() => 'BookFormatException: $message';
}

/// There is no live (not deleted) book with this [id].
class BookNotFoundException implements Exception {
  /// Creates the exception for book [id].
  const new(this.id);

  /// Id that was not found.
  final String id;

  @override
  String toString() => 'BookNotFoundException: $id';
}
