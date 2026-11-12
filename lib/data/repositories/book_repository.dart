import 'dart:io';

import 'package:drift/drift.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge.dart';
import 'package:fusionreflow/data/repositories/book_exceptions.dart';
import 'package:fusionreflow/data/services/book_file_service.dart';
import 'package:fusionreflow/data/services/database/app_database.dart';
import 'package:fusionreflow/data/services/rust_core_service.dart';
import 'package:fusionreflow/domain/models/book_entry.dart';
import 'package:fusionreflow/domain/models/book_format.dart';
import 'package:fusionreflow/domain/models/reading_position.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'book_repository.g.dart';

/// The library: converted books, their files and reading positions.
abstract interface class BookRepository {
  /// Live books, newest first (by `addedAt`).
  Stream<List<BookEntry>> watchAll();

  /// Stores a CBOR-encoded book. The same book (by source hash) is returned,
  /// not duplicated; a previously deleted one comes back with the same id.
  ///
  /// Throws [BookFormatException] if [bytes] are not a readable book.
  Future<BookEntry> add(Uint8List bytes, BookFormat format);

  /// CBOR bytes of book [id]; throws [BookNotFoundException] if it is not live.
  Future<Uint8List> load(String id);

  /// Remembers where the reader stopped; [progress] must be in `0..1`.
  Future<void> savePosition(
    String id,
    ReadingPosition position,
    double progress,
  );

  /// Deletes book [id] (soft); an unknown or deleted id is not an error.
  Future<void> delete(String id);
}

/// [BookRepository] over Drift (catalog) and files (book bytes).
class LocalBookRepository implements BookRepository {
  /// Creates the repository; the clock is injectable for tests.
  new({
    required AppDatabase database,
    required this._files,
    required this._rust,
    this._uuid = const Uuid(),
    this._clock = DateTime.now,
  }) : _db = database;

  final AppDatabase _db;
  final BookFileService _files;
  final RustCoreService _rust;
  final Uuid _uuid;
  final DateTime Function() _clock;

  Future<void>? _sweep;

  /// Removes orphan files once, before the first operation of any method.
  Future<void> _ready() =>
      _sweep ??= _removeOrphans().catchError((Object error, StackTrace stack) {
        _sweep = null; // let the next call retry
        Error.throwWithStackTrace(error, stack);
      });

  Future<void> _removeOrphans() async {
    await _files.deleteTemp();
    final live =
        (await (_db.selectOnly(_db.books)
                  ..addColumns([_db.books.id])
                  ..where(_db.books.deletedAt.isNull()))
                .map((row) => row.read(_db.books.id))
                .get())
            .toSet();
    for (final id in await _files.ids()) {
      if (!live.contains(id)) await _files.delete(id);
    }
  }

  SimpleSelectStatement<$BooksTable, BookRow> _live() =>
      _db.select(_db.books)..where((b) => b.deletedAt.isNull());

  Future<BookRow?> _byHash(String hash) => (_db.select(
    _db.books,
  )..where((b) => b.sourceHash.equals(hash))).getSingleOrNull();

  @override
  Stream<List<BookEntry>> watchAll() async* {
    await _ready();
    yield* (_live()..orderBy([(b) => OrderingTerm.desc(b.addedAt)]))
        .watch()
        .map((rows) => rows.map(_entry).toList());
  }

  @override
  Future<BookEntry> add(Uint8List bytes, BookFormat format) async {
    await _ready();
    // shortcut: any bridge error counts as bad bytes (a Rust panic too);
    // narrow to FormatError if the bridge starts failing for other reasons.
    final meta = await _rust
        .bookMeta(bytes)
        .onError<FrbException>(
          (error, _) => throw BookFormatException(error.toString()),
        );
    final existing = await _byHash(meta.sourceHash);
    if (existing != null && existing.deletedAt == null) return _entry(existing);

    final now = _clock();
    final id = existing?.id ?? _uuid.v4();
    final values = BooksCompanion(
      id: Value(id),
      title: Value(meta.title),
      authors: Value(meta.authors),
      language: Value(meta.language),
      format: Value(format),
      sourceHash: Value(meta.sourceHash),
      converterVersion: Value(meta.converterVersion),
      addedAt: Value(now),
      updatedAt: Value(now),
      lastReadAt: const Value(null),
      chapter: const Value(0),
      offset: const Value(0),
      progress: const Value(0),
      deletedAt: const Value(null),
    );
    // The file goes first, so a row never points to a missing file.
    await _files.write(id, bytes);
    try {
      await _db.into(_db.books).insertOnConflictUpdate(values);
    } on Object {
      // A revived id may be shared with a concurrent `add` that succeeded, so
      // its file stays; with a deleted row it is swept on the next start.
      if (existing == null) {
        try {
          await _files.delete(id);
        } on Object {
          // Keep the original insert error; a leftover file is swept later.
        }
      }
      // Lost a race with another `add` of the same book: return the winner.
      final winner = await _byHash(meta.sourceHash);
      if (winner != null && winner.deletedAt == null && winner.id != id) {
        return _entry(winner);
      }
      rethrow;
    }
    return BookEntry(
      id: id,
      title: meta.title,
      authors: meta.authors,
      language: meta.language,
      format: format,
      sourceHash: meta.sourceHash,
      converterVersion: meta.converterVersion,
      addedAt: now,
      position: ReadingPosition.start,
      progress: 0,
    );
  }

  @override
  Future<Uint8List> load(String id) async {
    await _ready();
    await _require(id);
    try {
      return await _files.read(id);
    } on PathNotFoundException {
      // The file was removed by hand: for the reader the book is gone.
      throw BookNotFoundException(id);
    }
  }

  @override
  Future<void> savePosition(
    String id,
    ReadingPosition position,
    double progress,
  ) async {
    if (progress.isNaN || progress < 0 || progress > 1) {
      throw ArgumentError.value(progress, 'progress', 'must be in 0..1');
    }
    await _ready();
    final now = _clock();
    final updated =
        await (_db.update(
          _db.books,
        )..where((b) => b.id.equals(id) & b.deletedAt.isNull())).write(
          BooksCompanion(
            chapter: Value(position.chapter),
            offset: Value(position.offset),
            progress: Value(progress),
            lastReadAt: Value(now),
            updatedAt: Value(now),
          ),
        );
    if (updated == 0) throw BookNotFoundException(id);
  }

  @override
  Future<void> delete(String id) async {
    await _ready();
    final now = _clock();
    final updated =
        await (_db.update(
          _db.books,
        )..where((b) => b.id.equals(id) & b.deletedAt.isNull())).write(
          BooksCompanion(deletedAt: Value(now), updatedAt: Value(now)),
        );
    if (updated > 0) await _files.delete(id);
  }

  Future<void> _require(String id) async {
    final row = await (_live()..where((b) => b.id.equals(id)))
        .getSingleOrNull();
    if (row == null) throw BookNotFoundException(id);
  }

  BookEntry _entry(BookRow row) => BookEntry(
    id: row.id,
    title: row.title,
    authors: row.authors,
    language: row.language,
    format: row.format,
    sourceHash: row.sourceHash,
    converterVersion: row.converterVersion,
    addedAt: row.addedAt,
    lastReadAt: row.lastReadAt,
    position: ReadingPosition(chapter: row.chapter, offset: row.offset),
    progress: row.progress,
  );
}

/// Provides the app's [BookRepository].
@Riverpod(keepAlive: true)
BookRepository bookRepository(Ref ref) => LocalBookRepository(
  database: ref.watch(appDatabaseProvider),
  files: ref.watch(bookFileServiceProvider),
  rust: ref.watch(rustCoreServiceProvider),
);
