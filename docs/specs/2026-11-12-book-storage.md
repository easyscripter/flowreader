# Хранилище книг (`BookRepository`): спека

**Задача плана:** 3.1 «Хранилище книг» (план 2, блок «Библиотека»)
**Стек:** оба (Flutter + Rust: одна функция моста)
**Ветка:** `feat/book-storage`
**Статус:** утверждена человеком 2026-11-12

## Цель

Приложение умеет сохранить сконвертированную книгу (CBOR-байты из импорта), показать список книг,
отдать байты книги читалке, запомнить позицию чтения и удалить книгу. Это опора для 3.2–3.4, 4.3 и 5.x.

## Границы

В задаче:
- база Drift (каталог книг, схема v1) и каталог файлов книг;
- функция моста `book_meta` (метаданные из CBOR);
- `BookRepository` с методами ниже, доменные модели `BookEntry`, `ReadingPosition`, `BookFormat`;
- уборка «сирот» (недописанные и неучтённые файлы) при первом обращении к репозиторию;
- провайдеры Riverpod.

Не в задаче (и где это делается):
- экран библиотеки, сортировка, загрузка фикстур в debug — 3.2;
- обложки и картинки книги (`Meta.cover`, `resources`) — 3.2 / 3.3; при удалении в 3.1 стирается только CBOR-файл;
- закладки — 3.4 (в ту же базу, новой таблицей с миграцией схемы);
- подсчёт SHA-256 исходника — импортёры 4.1 / 4.2 (поле `Book.source_hash` заполняет конвертер);
- ссылка на исходник (SAF URI), «хранить копию исходника», переконвертация — план 3 (колонка добавляется миграцией);
- разбор блоков для читалки (Dart-модель `Book`) — 5.2; в 3.1 `load` отдаёт байты;
- смысл полей `ReadingPosition` (что считать главой и смещением) — 5.2; хранилище хранит два целых как есть;
- FTS5-поиск, синхронизация — позже (план 4+), схема к синхронизации готова: UUID, `updatedAt`, `deletedAt`.

## Новые зависимости (согласованы на гриллинге)

- `dependencies`: `drift`, `drift_flutter`, `path_provider`, `uuid` — последние стабильные версии на момент работы.
- `dev_dependencies`: `drift_dev`.
- *Решение аналитика:* `drift_flutter` вместо прямого `sqlite3_flutter_libs` — это официальный способ открыть базу
  во Flutter (он сам тянет `sqlite3_flutter_libs` и `path_provider`). Других пакетов не добавлять.

## Интерфейсы

### Rust: `rust/bridge/src/api/book.rs` (новый модуль, `pub mod book;` в `api/mod.rs`)

```rust
/// Bibliographic data of an encoded book, for the library catalog.
pub struct BookMeta {
    pub title: String,
    pub authors: Vec<String>,
    pub language: Option<String>,
    pub source_hash: String,
    pub converter_version: String,
}

/// Decodes CBOR `bytes` (`flow_core::encode`) and returns its catalog data.
/// Errors: the `flow_core::decode` error as is (bad CBOR, unsupported `format_version`).
pub fn book_meta(bytes: Vec<u8>) -> Result<BookMeta, FormatError>;
```
- `FormatError` — `flow_core::FormatError`, отражается в Dart через `#[frb(mirror(FormatError))]`, как `ImportError` в
  `api/import.rs` (строковые ошибки в публичном API запрещены, AGENTS.md раздел 4).
- Мост тонкий: `flow_core::decode` + перекладка полей; новой логики в `flow-core` нет, формат блоков не меняется.
- Сгенерированный код моста перегенерировать (`flutter_rust_bridge_codegen generate`) и закоммитить.

### Dart: сервисы (`lib/data/services/`)

- `RustCoreService` (существующий): новый метод `BookMeta bookMeta(Uint8List bytes)`; ошибку моста не ловит.
- `lib/data/services/database/app_database.dart`: `@DriftDatabase(tables: [Books]) class AppDatabase`,
  `schemaVersion = 1`, конструктор `AppDatabase(QueryExecutor e)`; в приложении — `driftDatabase(name: 'fusionreflow')`.
  Провайдер `appDatabaseProvider` — `keepAlive: true`, закрывает базу в `ref.onDispose`.
- Таблица `Books` (`lib/data/services/database/books_table.dart`):

| Колонка | Тип | Примечание |
|---|---|---|
| `id` | text, PK | UUID v4 (`uuid`) |
| `title` | text | из `book_meta` |
| `authors` | text | JSON-массив строк через `TypeConverter<List<String>, String>` |
| `language` | text, nullable | |
| `format` | int | `BookFormat` через `intEnum` |
| `sourceHash` | text, **unique** | |
| `converterVersion` | text | |
| `addedAt` | dateTime | |
| `updatedAt` | dateTime | меняется при любом изменении строки |
| `lastReadAt` | dateTime, nullable | ставит `savePosition` |
| `chapter` | int, default 0 | позиция |
| `offset` | int, default 0 | позиция |
| `progress` | real, default 0.0 | 0.0…1.0 |
| `deletedAt` | dateTime, nullable | мягкое удаление |

- `lib/data/services/book_file_service.dart`: `class BookFileService` (без состояния) — работа с каталогом
  `<applicationSupportDirectory>/books/`. Конструктор принимает `Future<Directory> Function() root` (в тестах — временный
  каталог, в приложении — `getApplicationSupportDirectory`). Методы:
  `Future<void> write(String id, Uint8List bytes)` (атомарно: `<id>.cbor.tmp` → `flush` → `rename` в `<id>.cbor`),
  `Future<Uint8List> read(String id)`, `Future<void> delete(String id)` (нет файла — не ошибка),
  `Future<List<String>> ids()` (id всех `*.cbor`), `Future<void> deleteTemp()` (все `*.tmp`).

### Dart: домен (`lib/domain/models/`, freezed)

```dart
enum BookFormat { pdf, epub, fb2, fb2Zip }   // book_format.dart; порядок фиксирован (хранится индекс)

@freezed abstract class ReadingPosition { // reading_position.dart
  const factory ReadingPosition({required int chapter, required int offset}) = _ReadingPosition;
  static const start = ReadingPosition(chapter: 0, offset: 0);
}

@freezed abstract class BookEntry {        // book_entry.dart
  const factory BookEntry({
    required String id, required String title, required List<String> authors, String? language,
    required BookFormat format, required String sourceHash, required String converterVersion,
    required DateTime addedAt, DateTime? lastReadAt,
    required ReadingPosition position, required double progress,
  }) = _BookEntry;
}
```
`BookFormat` — своя доменная копия, потому что `domain` не импортирует код моста; перевод из `SourceKind` моста — в 4.3.

### Dart: репозиторий (`lib/data/repositories/book_repository.dart`)

```dart
abstract interface class BookRepository {
  Stream<List<BookEntry>> watchAll();                       // живые книги, по addedAt убыванию
  Future<BookEntry> add(Uint8List bytes, BookFormat format);
  Future<Uint8List> load(String id);
  Future<void> savePosition(String id, ReadingPosition position, double progress);
  Future<void> delete(String id);
}
class LocalBookRepository implements BookRepository { /* AppDatabase, BookFileService, RustCoreService, Uuid */ }
@Riverpod(keepAlive: true) BookRepository bookRepository(Ref ref);
```
Исключения (`lib/data/repositories/book_exceptions.dart`):
`BookFormatException(String message)` — байты не разбираются; `BookNotFoundException(String id)` — нет живой книги.

Поведение:
- **`add`**: 1) `bookMeta(bytes)`; `FormatError` моста → `BookFormatException(<текст ошибки>)`, ничего не записано. 2) Есть живая строка с тем же
  `sourceHash` → вернуть её, файл не трогать. 3) Есть удалённая строка с этим хешем → **воскрешение**: тот же `id`;
  файл пишется заново; метаданные из новых байт; `deletedAt = null`, позиция `start`, `progress = 0`,
  `lastReadAt = null`, `addedAt = updatedAt = now`. 4) Иначе новый UUID, файл, строка. Порядок всегда:
  сначала файл (атомарно), потом строка; если запись строки упала — удалить файл и пробросить ошибку.
  Нарушение `unique(sourceHash)` при гонке двух `add` — удалить свой файл и вернуть победившую строку.
- **`load`**: живая книга → байты файла; иначе `BookNotFoundException`.
- **`savePosition`**: `progress` вне `[0, 1]` или NaN → `ArgumentError`; книги нет → `BookNotFoundException`;
  иначе пишет позицию, `progress`, `lastReadAt = updatedAt = now`.
- **`delete`**: ставит `deletedAt = updatedAt = now`, затем удаляет файл. Неизвестный или уже удалённый id — без ошибки.
- **Уборка сирот** (*решение аналитика*): перед первой операцией любого метода (одна общая `Future`, повторно не
  запускается) — `deleteTemp()` и удаление `*.cbor`, у которых нет живой строки. Так прерванная запись не оставляет
  файлов, а строки без файла не бывает по порядку записи.
- Время — через инжектируемый `DateTime Function() clock` (по умолчанию `DateTime.now`), чтобы тесты были детерминированы.

## Тесты

Сначала пишутся падающие тесты (RED). Dart-тесты репозитория: Drift `NativeDatabase.memory()`, `BookFileService`
на `Directory.systemTemp.createTempSync()`, `RustCoreService` — фейк, возвращающий `BookMeta` по байтам
(хелпер в `test/helpers/fake_rust_core_service.dart`: байты `[n]` → книга с `sourceHash 'h$n'`, `title 'T$n'`; байты
`[0xFF]` → бросает). Фиксированные часы.

**Rust** (`rust/bridge/src/api/book.rs`, `#[cfg(test)]`):

| Тест | Проверяет | Вход → ожидание |
|---|---|---|
| `book_meta_reads_fixture` | разбор эталонной книги | `include_bytes!` `flow-core/tests/fixtures/book_v1.cbor` → поля равны `meta`, `source_hash`, `converter_version` из `sample_book()` (`flow-core/tests/model.rs`) |
| `book_meta_rejects_garbage` | кривой вход | `vec![0xFF, 0x00]` → `Err(FormatError::Corrupt(_))` |
| `book_meta_rejects_empty` | пустой вход | `vec![]` → `Err(FormatError::Corrupt(_))` |

**Dart** (`test/data/...`):

| Тест | Проверяет | Вход → ожидание |
|---|---|---|
| `rust_core_service_test`: `bookMeta delegates to bridge` | вызов моста | мок `RustLibApi` → тот же `BookMeta` |
| `book_file_service_test`: `write then read returns same bytes` | запись/чтение | `[1,2,3]` → `[1,2,3]`, файла `.tmp` нет |
| `book_file_service_test`: `delete missing file is no-op` | идемпотентность | несуществующий id → без исключения |
| `book_file_service_test`: `ids lists only cbor files` | список | `a.cbor`, `b.cbor.tmp` → `['a']` |
| `add stores entry and file` | добавление | `[1]` → `BookEntry(title 'T1', position start, progress 0)`, `load` → `[1]` |
| `add same hash returns existing` | Review Focus 5, нет дубля | `add([1])` дважды → один id, в `watchAll` одна книга |
| `add bad bytes throws and writes nothing` | кривой вход | `[0xFF]` → `BookFormatException`, файлов 0, строк 0 |
| `add after delete revives same id` | воскрешение | `add([1])`, `savePosition(..)`, `delete`, `add([1])` → тот же id, позиция `start`, `progress 0`, `deletedAt null` |
| `add removes file when insert fails` | откат | фейковая база бросает на insert → исключение проброшено, файлов 0 |
| `watchAll emits on add, savePosition, delete` | поток | последовательность списков: `[]`, `[A]`, `[A']`, `[]` |
| `watchAll hides deleted and sorts by addedAt desc` | фильтр и порядок | A (t1), B (t2), удалить A → `[B]`; без удаления → `[B, A]` |
| `load unknown or deleted throws` | ошибки | → `BookNotFoundException` |
| `savePosition stores position, progress, lastReadAt` | позиция | `(3, 120), 0.4` → поля в `BookEntry` |
| `savePosition rejects progress out of range` | валидация | `-0.1`, `1.1`, `NaN` → `ArgumentError` |
| `savePosition unknown id throws` | ошибки | → `BookNotFoundException` |
| `delete unknown id is no-op` | идемпотентность | → без исключения |
| `orphans are removed on first call` | Review Focus 5, прерванная запись | в каталоге `x.cbor.tmp` и `y.cbor` без строки → после `watchAll().first` файлов нет |
| `database survives reopen` | постоянство | файл-база (`NativeDatabase(File)` во временном каталоге), `add`, закрыть, открыть → книга на месте |

Архитектурный тест (`test/architecture_test.dart`) должен проходить без правок: `domain` не импортирует `data`
и код моста.

## Критерии приёмки

- Из `rust/`: `cargo fmt --check && cargo clippy --all-targets -- -D warnings && cargo test` — зелёные; покрытие `rust/bridge` ≥ 85% (`cargo llvm-cov`, раздел 9).
- `dart run build_runner build` не даёт изменений после коммита (сгенерированные `*.g.dart`, `*.freezed.dart`,
  `app_database.g.dart` закоммичены); код моста перегенерирован.
- `dart format --set-exit-if-changed lib test integration_test test_driver tool && dart analyze --fatal-infos && flutter test` — зелёные;
  покрытие `lib/data` и `lib/domain` ≥ 85% (`tool/check_coverage.dart`, раздел 9 AGENTS.md).
- Перед запуском на устройстве — `flutter clean` (отпечаток API моста изменился).
- В приложении ничего видимого не меняется; на Pixel 7 — запуск debug-сборки не падает (база создаётся при первом
  обращении, а в 3.1 обращений из UI нет — достаточно, что приложение стартует). Отдельного сценария QA нет.
- CI зелёный (на Linux-раннере для `NativeDatabase.memory()` нужна системная `libsqlite3`; если её нет —
  добавить установку в workflow и сказать человеку).

## Review Focus

- Прерванная запись в любой точке `add` (между `rename` и insert, во время `rename`): после перезапуска нет ни
  файла без строки, ни строки без файла.
- Повторный импорт того же файла, в том числе после удаления, и две одновременные `add` одних байт.
- Огромная книга: `book_meta` разбирает CBOR целиком — время на книге ~50 МБ терпимо (замерить в Rust-тесте
  вручную, в CI не включать), нет копирования байт больше одного раза на стороне Dart.
- Удаление, когда файл уже пропал (удалён вручную) — без ошибки.
- `progress` и позиция у воскрешённой книги сброшены.

## Решения, принятые на гриллинге

| Вопрос | Решение | Почему |
|---|---|---|
| Где каталог книг | Drift (SQLite) сразу | Нужен в 3.4 и по спеке MVP 3.6; уникальный индекс и транзакции закрывают Review Focus 5 |
| Откуда название и автор | Функция моста `book_meta` | Схема формата остаётся в одном месте (`flow_core::model`); Dart CBOR не разбирает |
| Что отдаёт `load` | Байты (`Uint8List`) | Решение R12; разбор блоков — 5.2 |
| Откуда хеш исходника | Из `Book.source_hash` через `book_meta` | Хеш уже в формате, его заполняет конвертер; снаружи не подсунуть (решение аналитика, пересмотрено) |
| Каталог файлов и id | `path_provider`, `uuid` | Стандартные пакеты, без своих велосипедов |
| Удаление | Мягкое (`deletedAt`) с воскрешением по хешу, позиция сбрасывается | Готовность к синхронизации по MVP 3.6; миграция позже дороже |
| Процент прочитанного | Параметр `progress` в `savePosition` | Читалка знает его сама; библиотека не разбирает книги |
| `ReadingPosition` | Два целых `(chapter, offset)`, смысл — в 5.2 | В формате нет глав, только блоки и оглавление (решение аналитика) |
| Уборка сирот | При первом обращении к репозиторию | Закрывает прерванную запись без отдельного запуска (решение аналитика) |
| Ссылка на исходник | Не в 3.1 | Нужна в плане 3; добавляется колонкой с миграцией |
