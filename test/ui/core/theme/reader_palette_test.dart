import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:fusionreflow/ui/core/theme/reader_palette.dart';

import '../../../helpers/contrast.dart';

void main() {
  // Порядок полей: pageBackground, pageText, surface, surfaceVariant,
  // onSurfaceVariant, outlineVariant, accent, onAccent, accentContainer.
  const expected = <ReaderPalette, List<int>>{
    ReaderPalette.light: [
      0xFFFDFDFB, 0xFF1D1F23, 0xFFFFFFFF, 0xFFEAEBF3, 0xFF565A75,
      0xFFDCDDE8, 0xFF4A3FD0, 0xFFFFFFFF, 0xFFE9E7FB, //
    ],
    ReaderPalette.dark: [
      0xFF0C0F22, 0xFFD7DBE2, 0xFF12162E, 0xFF1C2144, 0xFFA0A6CC,
      0xFF262B58, 0xFFA99BFF, 0xFF120C3A, 0xFF2B2570, //
    ],
    ReaderPalette.sepia: [
      0xFFF3E8D0, 0xFF3B2F20, 0xFFF8F1E2, 0xFFE4D9C1, 0xFF6B5A43,
      0xFFD5C8AB, 0xFF8A4A1C, 0xFFFFFFFF, 0xFFEAD6B6, //
    ],
    ReaderPalette.black: [
      0xFF000000, 0xFFCFCFCF, 0xFF0E0E0E, 0xFF1B1B1B, 0xFF9B9B9B,
      0xFF2A2A2A, 0xFFA99BFF, 0xFF000000, 0xFF1F1A50, //
    ],
  };

  List<Color> fields(ReaderPalette p) => [
    p.pageBackground,
    p.pageText,
    p.surface,
    p.surfaceVariant,
    p.onSurfaceVariant,
    p.outlineVariant,
    p.accent,
    p.onAccent,
    p.accentContainer,
  ];

  test('palettes match design', () {
    expected.forEach((p, hex) {
      expect(fields(p), hex.map(Color.new).toList());
    });
    expect(ReaderPalette.values, [
      ReaderPalette.light,
      ReaderPalette.dark,
      ReaderPalette.sepia,
      ReaderPalette.black,
    ]);
  });

  test('text contrast at least 4.5', () {
    for (final p in ReaderPalette.values) {
      final pairs = <(Color, Color)>[
        (p.pageText, p.pageBackground),
        (p.onSurfaceVariant, p.pageBackground),
        (p.onSurfaceVariant, p.surface),
        (p.onSurfaceVariant, p.surfaceVariant),
        (p.onAccent, p.accent),
        (p.accent, p.accentContainer),
        (p.accent, p.surface),
      ];
      for (final (a, b) in pairs) {
        expect(contrastRatio(a, b), greaterThanOrEqualTo(4.5), reason: '$a $b');
      }
    }
  });
}
