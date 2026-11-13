import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('font asset is declared and present', () {
    final pubspec = File('pubspec.yaml').readAsStringSync();
    expect(pubspec, contains('family: GolosText'));
    expect(pubspec, contains('assets/fonts/golos_text/GolosText.ttf'));

    final ttf = File('assets/fonts/golos_text/GolosText.ttf').readAsBytesSync();
    // Каталог таблиц SFNT: numTables (uint16 со смещения 4), записи по 16
    // байт со смещения 12, тег — первые 4 байта. 'fvar' = вариативный шрифт.
    final data = ByteData.sublistView(ttf);
    final numTables = data.getUint16(4);
    final tags = [
      for (var i = 0; i < numTables; i++)
        String.fromCharCodes(ttf.sublist(12 + i * 16, 16 + i * 16)),
    ];
    expect(tags, contains('fvar'));
    expect(File('assets/fonts/golos_text/OFL.txt').existsSync(), isTrue);
  });
}
