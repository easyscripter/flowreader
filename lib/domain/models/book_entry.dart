import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fusionreflow/domain/models/book_format.dart';
import 'package:fusionreflow/domain/models/reading_position.dart';

part 'book_entry.freezed.dart';

/// A book in the library catalog.
@freezed
abstract class BookEntry with _$BookEntry {
  /// Creates a catalog entry; [progress] is in `0.0..1.0`.
  const factory({
    required String id,
    required String title,
    required List<String> authors,
    required BookFormat format,
    required String sourceHash,
    required String converterVersion,
    required DateTime addedAt,
    required ReadingPosition position,
    required double progress,
    String? language,
    DateTime? lastReadAt,
  }) = _BookEntry;
}
