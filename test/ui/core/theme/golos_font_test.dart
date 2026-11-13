import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('font asset is declared and present', () {
    final pubspec = File('pubspec.yaml').readAsStringSync();
    expect(pubspec, contains('family: GolosText'));
    expect(pubspec, contains('assets/fonts/golos_text/GolosText.ttf'));

    final ttf = File('assets/fonts/golos_text/GolosText.ttf').readAsBytesSync();
    // 'fvar' в каталоге таблиц SFNT: признак вариативного шрифта.
    final head = String.fromCharCodes(ttf.sublist(0, 512));
    expect(head, contains('fvar'));
    expect(File('assets/fonts/golos_text/OFL.txt').existsSync(), isTrue);
  });
}
