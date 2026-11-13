import 'package:flutter_test/flutter_test.dart';
import 'package:fusionreflow/utils/window_size_class.dart';

void main() {
  test('window size class boundaries', () {
    final expected = <double, WindowSizeClass>{
      0: WindowSizeClass.compact,
      599.9: WindowSizeClass.compact,
      600: WindowSizeClass.medium,
      839.9: WindowSizeClass.medium,
      840: WindowSizeClass.expanded,
      1180: WindowSizeClass.expanded,
      -1: WindowSizeClass.compact,
      double.nan: WindowSizeClass.compact,
      double.infinity: WindowSizeClass.compact,
    };
    for (final MapEntry(key: width, value: cls) in expected.entries) {
      expect(windowSizeClassOf(width), cls, reason: '$width');
    }
  });
}
