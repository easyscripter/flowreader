import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fusionreflow/ui/core/theme/app_text_theme.dart';

void main() {
  test('scale matches design', () {
    // стиль: (размер, высота строки, letterSpacing)
    final expected = <TextStyle?, (double, double, double)>{
      appTextTheme.headlineLarge: (32, 40, -0.64),
      appTextTheme.headlineMedium: (26, 32, -0.52),
      appTextTheme.titleLarge: (20, 28, 0),
      appTextTheme.titleMedium: (16, 24, 0),
      appTextTheme.titleSmall: (14, 20, 0),
      appTextTheme.bodyLarge: (16, 24, 0),
      appTextTheme.bodyMedium: (15, 22, 0),
      appTextTheme.bodySmall: (13, 18, 0),
      appTextTheme.labelLarge: (15, 20, 0),
      appTextTheme.labelMedium: (13, 16, 0),
      appTextTheme.labelSmall: (12, 16, 0),
    };
    for (final MapEntry(key: style, value: v) in expected.entries) {
      expect(style?.fontFamily, 'GolosText');
      expect(style?.fontSize, v.$1);
      expect(style?.height, closeTo(v.$2 / v.$1, 0.001));
      expect(style?.letterSpacing, closeTo(v.$3, 0.0001));
    }
  });

  test('weights match design', () {
    expect(appTextTheme.headlineLarge?.fontWeight?.value, 650);
    expect(appTextTheme.labelMedium?.fontWeight?.value, 550);
    expect(appTextTheme.labelSmall?.fontWeight?.value, 500);
    expect(appTextTheme.bodyMedium?.fontWeight?.value, 400);
    expect(appTextTheme.titleMedium?.fontWeight?.value, 600);
  });
}
