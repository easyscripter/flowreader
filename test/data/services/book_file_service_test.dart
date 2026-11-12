import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:fusionreflow/data/services/book_file_service.dart';

void main() {
  late Directory root;
  late BookFileService service;

  setUp(() {
    root = Directory.systemTemp.createTempSync('book_files_');
    service = BookFileService(() async => root);
  });

  tearDown(() => root.deleteSync(recursive: true));

  Directory books() => Directory('${root.path}/books');

  test('write then read returns same bytes', () async {
    await service.write('a', Uint8List.fromList([1, 2, 3]));

    expect(await service.read('a'), [1, 2, 3]);
    expect(books().listSync().map((e) => e.path.split('/').last), ['a.cbor']);
  });

  test('delete missing file is no-op', () async {
    await service.delete('nope');
  });

  test('delete removes the file', () async {
    await service.write('a', Uint8List.fromList([1]));
    await service.delete('a');

    expect(await service.ids(), isEmpty);
  });

  test('ids lists only cbor files', () async {
    books().createSync(recursive: true);
    File('${books().path}/a.cbor').writeAsBytesSync([1]);
    File('${books().path}/b.cbor.tmp').writeAsBytesSync([1]);

    expect(await service.ids(), ['a']);
  });

  test('deleteTemp removes tmp files and keeps cbor', () async {
    books().createSync(recursive: true);
    File('${books().path}/a.cbor').writeAsBytesSync([1]);
    File('${books().path}/b.cbor.tmp').writeAsBytesSync([1]);

    await service.deleteTemp();

    expect(await service.ids(), ['a']);
    expect(books().listSync(), hasLength(1));
  });

  test('ids and deleteTemp work before the directory exists', () async {
    expect(await service.ids(), isEmpty);
    await service.deleteTemp();
  });
}
