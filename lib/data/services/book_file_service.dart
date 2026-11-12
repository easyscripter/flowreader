import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'book_file_service.g.dart';

const _extension = '.cbor';
const _tmpExtension = '.tmp';

/// Stateless access to the directory with CBOR book files
/// (`<root>/books/<id>.cbor`).
class BookFileService {
  /// Creates the service; [_root] resolves the app's storage directory.
  const new(this._root);

  final Future<Directory> Function() _root;

  Future<Directory> _dir() => _root().then(
    (root) => Directory('${root.path}/books').create(recursive: true),
  );

  File _file(Directory dir, String id, [String ext = _extension]) =>
      File('${dir.path}/$id$ext');

  /// Writes [bytes] atomically: a temp file is flushed, then renamed to
  /// `<id>.cbor`. The temp name is unique, so concurrent writes of the same
  /// [id] do not share a file.
  Future<void> write(String id, Uint8List bytes) async {
    final dir = await _dir();
    final tmp = _file(dir, id, '.${const Uuid().v4()}$_tmpExtension');
    final handle = await tmp.open(mode: FileMode.write);
    try {
      await handle.writeFrom(bytes);
      await handle.flush();
    } finally {
      await handle.close();
    }
    await tmp.rename(_file(dir, id).path);
  }

  /// Reads the bytes of book [id].
  Future<Uint8List> read(String id) =>
      _dir().then((dir) => _file(dir, id).readAsBytes());

  /// Deletes the file of book [id]; a missing file is not an error.
  Future<void> delete(String id) async {
    try {
      await _file(await _dir(), id).delete();
    } on PathNotFoundException {
      // Already gone (e.g. removed by hand): nothing to do.
    }
  }

  /// Ids of all stored books (`*.cbor` files).
  Future<List<String>> ids() async => [
    for (final entity in await (await _dir()).list().toList())
      if (entity is File && entity.path.endsWith(_extension))
        _name(entity.path, _extension),
  ];

  /// Deletes leftovers of interrupted writes (`*.tmp`).
  Future<void> deleteTemp() async {
    for (final entity in await (await _dir()).list().toList()) {
      if (entity is File && entity.path.endsWith(_tmpExtension)) {
        await entity.delete();
      }
    }
  }

  String _name(String path, String ext) =>
      path.substring(path.lastIndexOf('/') + 1, path.length - ext.length);
}

/// Provides the [BookFileService] rooted in the app support directory.
@Riverpod(keepAlive: true)
BookFileService bookFileService(Ref ref) =>
    const BookFileService(getApplicationSupportDirectory);
