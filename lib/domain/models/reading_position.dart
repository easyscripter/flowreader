import 'package:freezed_annotation/freezed_annotation.dart';

part 'reading_position.freezed.dart';

/// Where the reader stopped. The meaning of the fields is defined by the
/// reader (task 5.2); the library stores both integers as they are.
@freezed
abstract class ReadingPosition with _$ReadingPosition {
  /// Creates a position at [chapter] and [offset].
  const factory({required int chapter, required int offset}) = _ReadingPosition;

  /// The beginning of a book.
  static const start = ReadingPosition(chapter: 0, offset: 0);
}
