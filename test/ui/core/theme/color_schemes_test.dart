import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fusionreflow/ui/core/theme/app_color_schemes.dart';

import '../../../helpers/contrast.dart';

void main() {
  void expectRoles(ColorScheme s, Map<String, (Color, int)> roles) {
    roles.forEach((name, r) {
      expect(r.$1, Color(r.$2), reason: name);
    });
  }

  test('light scheme matches design', () {
    const s = lightColorScheme;
    expect(s.brightness, Brightness.light);
    expectRoles(s, {
      'primary': (s.primary, 0xFF4A3FD0),
      'onPrimary': (s.onPrimary, 0xFFFFFFFF),
      'primaryContainer': (s.primaryContainer, 0xFFE9E7FB),
      'onPrimaryContainer': (s.onPrimaryContainer, 0xFF4A3FD0),
      'secondaryContainer': (s.secondaryContainer, 0xFFE9E7FB),
      'onSecondaryContainer': (s.onSecondaryContainer, 0xFF4A3FD0),
      'tertiary': (s.tertiary, 0xFF0E7C86),
      'surface': (s.surface, 0xFFFFFFFF),
      'surfaceContainerLowest': (s.surfaceContainerLowest, 0xFFF4F4F9),
      'surfaceContainerLow': (s.surfaceContainerLow, 0xFFF1F2F8),
      'surfaceContainer': (s.surfaceContainer, 0xFFEFF0F6),
      'surfaceContainerHigh': (s.surfaceContainerHigh, 0xFFEDEEF5),
      'surfaceContainerHighest': (s.surfaceContainerHighest, 0xFFEAEBF3),
      'onSurface': (s.onSurface, 0xFF12142A),
      'onSurfaceVariant': (s.onSurfaceVariant, 0xFF565A75),
      'outlineVariant': (s.outlineVariant, 0xFFDCDDE8),
      'error': (s.error, 0xFFB3261E),
      'onError': (s.onError, 0xFFFFFFFF),
      'inverseSurface': (s.inverseSurface, 0xFF12142A),
      'onInverseSurface': (s.onInverseSurface, 0xFFF4F4F9),
      'surfaceTint': (s.surfaceTint, 0x00000000),
    });
  });

  test('dark scheme matches design', () {
    const s = darkColorScheme;
    expect(s.brightness, Brightness.dark);
    expectRoles(s, {
      'primary': (s.primary, 0xFFA99BFF),
      'onPrimary': (s.onPrimary, 0xFF120C3A),
      'primaryContainer': (s.primaryContainer, 0xFF2B2570),
      'onPrimaryContainer': (s.onPrimaryContainer, 0xFFA99BFF),
      'secondaryContainer': (s.secondaryContainer, 0xFF2B2570),
      'onSecondaryContainer': (s.onSecondaryContainer, 0xFFA99BFF),
      'tertiary': (s.tertiary, 0xFF3CD6D0),
      'surface': (s.surface, 0xFF12162E),
      'surfaceContainerLowest': (s.surfaceContainerLowest, 0xFF0C0F22),
      'surfaceContainerLow': (s.surfaceContainerLow, 0xFF0F1328),
      'surfaceContainer': (s.surfaceContainer, 0xFF12162E),
      'surfaceContainerHigh': (s.surfaceContainerHigh, 0xFF171C3B),
      'surfaceContainerHighest': (s.surfaceContainerHighest, 0xFF1C2144),
      'onSurface': (s.onSurface, 0xFFEEF0FF),
      'onSurfaceVariant': (s.onSurfaceVariant, 0xFFA0A6CC),
      'outlineVariant': (s.outlineVariant, 0xFF262B58),
      'error': (s.error, 0xFFFF8A80),
      'onError': (s.onError, 0xFF120C3A),
      'inverseSurface': (s.inverseSurface, 0xFFEEF0FF),
      'onInverseSurface': (s.onInverseSurface, 0xFF0C0F22),
      'surfaceTint': (s.surfaceTint, 0x00000000),
    });
  });

  test('tonal roles equal primary container', () {
    for (final s in [lightColorScheme, darkColorScheme]) {
      expect(s.secondaryContainer, s.primaryContainer);
      expect(s.onSecondaryContainer, s.primary);
    }
  });

  test('text contrast at least 4.5', () {
    for (final s in [lightColorScheme, darkColorScheme]) {
      final pairs = <(Color, Color)>[
        (s.onSurface, s.surface),
        (s.onSurface, s.surfaceContainerLowest),
        (s.onSurfaceVariant, s.surface),
        (s.onSurfaceVariant, s.surfaceContainerLowest),
        (s.onSurfaceVariant, s.surfaceContainerHighest),
        (s.onPrimary, s.primary),
        (s.primary, s.primaryContainer),
        (s.primary, s.surface),
        (s.error, s.surface),
        (s.onError, s.error),
        (s.onInverseSurface, s.inverseSurface),
      ];
      for (final (a, b) in pairs) {
        expect(
          contrastRatio(a, b),
          greaterThanOrEqualTo(4.5),
          reason: '$a on $b (${s.brightness})',
        );
      }
    }
  });
}
