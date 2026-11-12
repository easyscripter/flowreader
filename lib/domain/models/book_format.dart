/// Source format of a book. The order is fixed: the index is stored in the DB.
enum BookFormat {
  /// PDF document.
  pdf,

  /// EPUB e-book.
  epub,

  /// FictionBook 2.
  fb2,

  /// FictionBook 2 packed into a ZIP archive.
  fb2Zip,
}
