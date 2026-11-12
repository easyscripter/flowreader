import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:fusionreflow/domain/models/book_format.dart';

/// Stores `List<String>` as a JSON array in a text column.
class StringListConverter extends TypeConverter<List<String>, String> {
  /// Creates the converter.
  const new();

  @override
  List<String> fromSql(String fromDb) =>
      (jsonDecode(fromDb) as List<dynamic>).cast<String>();

  @override
  String toSql(List<String> value) => jsonEncode(value);
}

/// Library catalog (schema v1). Rows are soft-deleted via `deletedAt`.
@DataClassName('BookRow')
class Books extends Table {
  /// UUID v4.
  TextColumn get id => text()();

  /// Title from `book_meta`.
  TextColumn get title => text()();

  /// Authors as a JSON array.
  TextColumn get authors => text().map(const StringListConverter())();

  /// Language tag, if the book has one.
  TextColumn get language => text().nullable()();

  /// [BookFormat] index.
  IntColumn get format => intEnum<BookFormat>()();

  /// SHA-256 of the source file, filled by the converter.
  TextColumn get sourceHash => text().unique()();

  /// Version of the converter that produced the book.
  TextColumn get converterVersion => text()();

  /// When the book was added (or revived).
  DateTimeColumn get addedAt => dateTime()();

  /// Changes with every change of the row.
  DateTimeColumn get updatedAt => dateTime()();

  /// Set by `savePosition`.
  DateTimeColumn get lastReadAt => dateTime().nullable()();

  /// Reading position: chapter.
  IntColumn get chapter => integer().withDefault(const Constant(0))();

  /// Reading position: offset.
  IntColumn get offset => integer().withDefault(const Constant(0))();

  /// Read share, `0.0..1.0`.
  RealColumn get progress => real().withDefault(const Constant(0))();

  /// Soft deletion time.
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
