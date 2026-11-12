import 'dart:io';

import 'package:drift/drift.dart' hide isNull;
import 'package:drift/native.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fusionreflow/data/repositories/book_exceptions.dart';
import 'package:fusionreflow/data/repositories/book_repository.dart';
import 'package:fusionreflow/data/services/book_file_service.dart';
import 'package:fusionreflow/data/services/database/app_database.dart';
import 'package:fusionreflow/data/services/rust_core_service.dart';
import 'package:fusionreflow/domain/models/book_entry.dart';
import 'package:fusionreflow/domain/models/book_format.dart';
import 'package:fusionreflow/domain/models/reading_position.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../helpers/fake_rust_core_service.dart';

/// Fails every INSERT while [enabled], and the next [failNext] INSERTs.
class _FailingInsert extends QueryInterceptor {
  bool enabled = false;
  int failNext = 0;

  @override
  Future<int> runInsert(
    QueryExecutor executor,
    String statement,
    List<Object?> args,
  ) {
    if (failNext > 0) {
      failNext--;
      throw StateError('insert failed');
    }
    if (enabled) throw StateError('insert failed');
    return super.runInsert(executor, statement, args);
  }
}

/// Files whose cleanup can be made to fail.
class _FlakyFiles extends BookFileService {
  new(Directory dir) : super(() async => dir);

  bool failDelete = false;
  bool failDeleteTemp = false;

  @override
  Future<void> delete(String id) => failDelete
      ? Future.error(StateError('cleanup failed'))
      : super.delete(id);

  @override
  Future<void> deleteTemp() {
    if (!failDeleteTemp) return super.deleteTemp();
    failDeleteTemp = false;
    return Future.error(StateError('sweep failed'));
  }
}

Uint8List _b(int n) => Uint8List.fromList([n]);

void main() {
  // Every test opens its own in-memory database on purpose.
  TestWidgetsFlutterBinding.ensureInitialized();
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;

  late Directory dir;
  late AppDatabase db;
  late _FailingInsert failing;
  late BookFileService files;
  late DateTime now;
  late LocalBookRepository repo;

  LocalBookRepository makeRepo(AppDatabase database) => LocalBookRepository(
    database: database,
    files: files,
    rust: FakeRustCoreService(),
    clock: () => now,
  );

  setUp(() {
    dir = Directory.systemTemp.createTempSync('book_repo_');
    files = BookFileService(() async => dir);
    now = DateTime(2026, 11, 12, 10);
    failing = _FailingInsert();
    db = AppDatabase(NativeDatabase.memory().interceptWith(failing));
    repo = makeRepo(db);
  });

  tearDown(() async {
    await db.close();
    dir.deleteSync(recursive: true);
  });

  Future<List<BookRow>> rows() => db.select(db.books).get();

  test('add stores entry and file', () async {
    final entry = await repo.add(_b(1), BookFormat.epub);

    expect(
      entry,
      BookEntry(
        id: entry.id,
        title: 'T1',
        authors: const ['A1'],
        format: BookFormat.epub,
        sourceHash: 'h1',
        converterVersion: 'test',
        addedAt: now,
        position: ReadingPosition.start,
        progress: 0,
      ),
    );
    expect(await repo.load(entry.id), [1]);
    expect(await files.ids(), [entry.id]);
  });

  test('add same hash returns existing', () async {
    final first = await repo.add(_b(1), BookFormat.epub);
    final second = await repo.add(_b(1), BookFormat.epub);

    expect(second.id, first.id);
    expect(await repo.watchAll().first, hasLength(1));
  });

  test('concurrent add of the same bytes yields one book', () async {
    final results = await Future.wait([
      repo.add(_b(1), BookFormat.epub),
      repo.add(_b(1), BookFormat.epub),
    ]);

    expect(results[0].id, results[1].id);
    expect(await rows(), hasLength(1));
    expect(await files.ids(), [results[0].id]);
  });

  test('concurrent add after delete returns the same revived book', () async {
    final first = await repo.add(_b(1), BookFormat.epub);
    await repo.delete(first.id);

    final results = await Future.wait([
      repo.add(_b(1), BookFormat.epub),
      repo.add(_b(1), BookFormat.epub),
    ]);

    expect(results.map((e) => e.id), [first.id, first.id]);
    expect(await rows(), hasLength(1));
    expect(await repo.load(first.id), [1]);
  });

  test('failed revival does not delete the file of a concurrent add', () async {
    final first = await repo.add(_b(1), BookFormat.epub);
    await repo.delete(first.id);
    failing.failNext = 1;

    final results = await Future.wait([
      for (var i = 0; i < 2; i++)
        repo
            .add(_b(1), BookFormat.epub)
            .then<Object>((e) => e, onError: (Object e) => e),
    ]);

    expect(results.whereType<BookEntry>(), hasLength(1));
    expect(results.whereType<StateError>(), hasLength(1));
    expect(await repo.load(first.id), [1]);
  });

  test('add keeps the insert error when file cleanup fails too', () async {
    final flaky = _FlakyFiles(dir);
    final flakyRepo = LocalBookRepository(
      database: db,
      files: flaky,
      rust: FakeRustCoreService(),
      clock: () => now,
    );
    await flakyRepo.watchAll().first; // finish the orphan sweep first
    failing.enabled = true;
    flaky.failDelete = true;

    await expectLater(
      flakyRepo.add(_b(1), BookFormat.epub),
      throwsA(isA<StateError>().having((e) => e.message, 'm', 'insert failed')),
    );
  });

  test('a failed orphan sweep is retried on the next call', () async {
    final flaky = _FlakyFiles(dir)..failDeleteTemp = true;
    final flakyRepo = LocalBookRepository(
      database: db,
      files: flaky,
      rust: FakeRustCoreService(),
      clock: () => now,
    );

    await expectLater(flakyRepo.watchAll().first, throwsStateError);

    expect(await flakyRepo.watchAll().first, isEmpty);
  });

  test('load of a live book whose file is gone throws not found', () async {
    final a = await repo.add(_b(1), BookFormat.epub);
    await files.delete(a.id);

    await expectLater(repo.load(a.id), throwsA(isA<BookNotFoundException>()));
  });

  test('add bad bytes throws and writes nothing', () async {
    await expectLater(
      repo.add(badBookBytes, BookFormat.epub),
      throwsA(
        isA<BookFormatException>().having(
          (e) => e.message,
          'message',
          contains('bad bytes'),
        ),
      ),
    );

    expect(await files.ids(), isEmpty);
    expect(await rows(), isEmpty);
  });

  test('add after delete revives same id', () async {
    final first = await repo.add(_b(1), BookFormat.epub);
    await repo.savePosition(
      first.id,
      const ReadingPosition(chapter: 3, offset: 120),
      0.4,
    );
    await repo.delete(first.id);
    now = DateTime(2026, 11, 13, 10);

    final revived = await repo.add(_b(1), BookFormat.epub);

    expect(revived.id, first.id);
    expect(revived.position, ReadingPosition.start);
    expect(revived.progress, 0);
    expect(revived.lastReadAt, isNull);
    expect(revived.addedAt, now);
    final row = (await rows()).single;
    expect(row.deletedAt, isNull);
    expect(row.updatedAt, now);
    expect(await repo.load(first.id), [1]);
  });

  test('add removes file when insert fails', () async {
    failing.enabled = true;

    await expectLater(
      repo.add(_b(1), BookFormat.epub),
      throwsA(isA<StateError>()),
    );

    expect(await files.ids(), isEmpty);
  });

  test('watchAll emits on add, savePosition, delete', () async {
    final emitted = <List<BookEntry>>[];
    final sub = repo.watchAll().listen(emitted.add);
    addTearDown(sub.cancel);
    await pumpEventQueue();

    final a = await repo.add(_b(1), BookFormat.epub);
    await pumpEventQueue();
    await repo.savePosition(
      a.id,
      const ReadingPosition(chapter: 1, offset: 2),
      0.5,
    );
    await pumpEventQueue();
    await repo.delete(a.id);
    await pumpEventQueue();

    expect(emitted, hasLength(4));
    expect(emitted[0], isEmpty);
    expect(emitted[1].single.id, a.id);
    expect(emitted[2].single.progress, 0.5);
    expect(emitted[3], isEmpty);
  });

  test('watchAll hides deleted and sorts by addedAt desc', () async {
    final a = await repo.add(_b(1), BookFormat.epub);
    now = DateTime(2026, 11, 12, 11);
    final b = await repo.add(_b(2), BookFormat.fb2);

    expect((await repo.watchAll().first).map((e) => e.id), [b.id, a.id]);

    await repo.delete(a.id);

    expect((await repo.watchAll().first).map((e) => e.id), [b.id]);
  });

  test('load unknown or deleted throws', () async {
    await expectLater(
      repo.load('missing'),
      throwsA(isA<BookNotFoundException>()),
    );
    final a = await repo.add(_b(1), BookFormat.epub);
    await repo.delete(a.id);

    await expectLater(repo.load(a.id), throwsA(isA<BookNotFoundException>()));
  });

  test('savePosition stores position, progress, lastReadAt', () async {
    final a = await repo.add(_b(1), BookFormat.epub);
    now = DateTime(2026, 11, 12, 12);

    await repo.savePosition(
      a.id,
      const ReadingPosition(chapter: 3, offset: 120),
      0.4,
    );

    final entry = (await repo.watchAll().first).single;
    expect(entry.position, const ReadingPosition(chapter: 3, offset: 120));
    expect(entry.progress, 0.4);
    expect(entry.lastReadAt, now);
    expect((await rows()).single.updatedAt, now);
  });

  test('savePosition rejects progress out of range', () async {
    final a = await repo.add(_b(1), BookFormat.epub);

    for (final progress in [-0.1, 1.1, double.nan]) {
      await expectLater(
        repo.savePosition(a.id, ReadingPosition.start, progress),
        throwsArgumentError,
      );
    }
  });

  test('savePosition unknown id throws', () async {
    await expectLater(
      repo.savePosition('missing', ReadingPosition.start, 0.1),
      throwsA(isA<BookNotFoundException>()),
    );
  });

  test('delete unknown id is no-op', () async {
    await repo.delete('missing');
  });

  test('delete works when the file is already gone', () async {
    final a = await repo.add(_b(1), BookFormat.epub);
    await files.delete(a.id);

    await repo.delete(a.id);

    expect(await repo.watchAll().first, isEmpty);
  });

  test('delete twice is no-op and keeps the first deletedAt', () async {
    final a = await repo.add(_b(1), BookFormat.epub);
    await repo.delete(a.id);
    final deletedAt = (await rows()).single.deletedAt;
    now = DateTime(2026, 11, 14);

    await repo.delete(a.id);

    expect((await rows()).single.deletedAt, deletedAt);
    expect(await files.ids(), isEmpty);
  });

  test('orphans are removed on first call', () async {
    final books = Directory('${dir.path}/books')..createSync(recursive: true);
    File('${books.path}/x.cbor.tmp').writeAsBytesSync([1]);
    File('${books.path}/y.cbor').writeAsBytesSync([1]);

    await repo.watchAll().first;

    expect(books.listSync(), isEmpty);
  });

  test('orphans are swept once, before the first operation', () async {
    final a = await repo.add(_b(1), BookFormat.epub);
    File('${dir.path}/books/late.cbor').writeAsBytesSync([1]);

    await repo.watchAll().first;

    expect(await files.ids(), unorderedEquals([a.id, 'late']));
  });

  test('database survives reopen', () async {
    final dbFile = File('${dir.path}/catalog.sqlite');
    var database = AppDatabase(NativeDatabase(dbFile));
    final added = await makeRepo(database).add(_b(1), BookFormat.epub);
    await database.close();

    database = AppDatabase(NativeDatabase(dbFile));
    addTearDown(database.close);
    final books = await makeRepo(database).watchAll().first;

    expect(books.single.id, added.id);
    expect(await makeRepo(database).load(added.id), [1]);
  });

  test('exceptions describe themselves', () {
    expect(const BookFormatException('x').toString(), contains('x'));
    expect(const BookNotFoundException('id1').toString(), contains('id1'));
  });

  test('appDatabaseProvider closes the database on dispose', () async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
          const MethodChannel('plugins.flutter.io/path_provider'),
          (_) async => dir.path,
        );
    addTearDown(
      () => TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
            const MethodChannel('plugins.flutter.io/path_provider'),
            null,
          ),
    );
    final container = ProviderContainer();
    final database = container.read(appDatabaseProvider);
    await database.customSelect('select 1').get();

    container.dispose();
    await pumpEventQueue();

    await expectLater(
      database.customSelect('select 1').get(),
      throwsA(anything),
    );
  });

  test('bookFileServiceProvider provides a BookFileService', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    expect(container.read(bookFileServiceProvider), isA<BookFileService>());
  });

  test('bookRepositoryProvider wires the local repository', () {
    final container = ProviderContainer(
      overrides: [
        appDatabaseProvider.overrideWithValue(db),
        bookFileServiceProvider.overrideWithValue(files),
        rustCoreServiceProvider.overrideWithValue(FakeRustCoreService()),
      ],
    );
    addTearDown(container.dispose);

    expect(container.read(bookRepositoryProvider), isA<LocalBookRepository>());
  });
}
