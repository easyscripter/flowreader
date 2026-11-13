import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';

/// Палитра читалки: страница книги и её хром.
///
/// Обычный класс, не `ThemeExtension`: палитра выбирается настройкой
/// независимо от темы приложения (тема тёмная, палитра сепия).
///
/// Поля `light` и `dark` повторяют цвета `ColorScheme`, но это разные знания:
/// палитра страницы и тема приложения меняются по разным причинам, поэтому
/// общей константы нет.
@immutable
class ReaderPalette {
  const new({
    required this.pageBackground,
    required this.pageText,
    required this.surface,
    required this.surfaceVariant,
    required this.onSurfaceVariant,
    required this.outlineVariant,
    required this.accent,
    required this.onAccent,
    required this.accentContainer,
  });

  /// Фон страницы книги.
  final Color pageBackground;

  /// Текст книги.
  final Color pageText;

  /// Панель управления, оглавление, лист настроек чтения.
  final Color surface;

  /// Чипы, дорожка ползунка.
  final Color surfaceVariant;

  /// Колонтитул, подписи.
  final Color onSurfaceVariant;

  /// Разделители.
  final Color outlineVariant;

  /// Ползунок, активный чип, кнопки.
  final Color accent;

  /// Текст и значки на [accent].
  final Color onAccent;

  /// Фон выбранного чипа / пункта оглавления.
  final Color accentContainer;

  static const light = ReaderPalette(
    pageBackground: Color(0xFFFDFDFB),
    pageText: Color(0xFF1D1F23),
    surface: Color(0xFFFFFFFF),
    surfaceVariant: Color(0xFFEAEBF3),
    onSurfaceVariant: Color(0xFF565A75),
    outlineVariant: Color(0xFFDCDDE8),
    accent: Color(0xFF4A3FD0),
    onAccent: Color(0xFFFFFFFF),
    accentContainer: Color(0xFFE9E7FB),
  );

  static const dark = ReaderPalette(
    pageBackground: Color(0xFF0C0F22),
    pageText: Color(0xFFD7DBE2),
    surface: Color(0xFF12162E),
    surfaceVariant: Color(0xFF1C2144),
    onSurfaceVariant: Color(0xFFA0A6CC),
    outlineVariant: Color(0xFF262B58),
    accent: Color(0xFFA99BFF),
    onAccent: Color(0xFF120C3A),
    accentContainer: Color(0xFF2B2570),
  );

  static const sepia = ReaderPalette(
    pageBackground: Color(0xFFF3E8D0),
    pageText: Color(0xFF3B2F20),
    surface: Color(0xFFF8F1E2),
    surfaceVariant: Color(0xFFE4D9C1),
    onSurfaceVariant: Color(0xFF6B5A43),
    outlineVariant: Color(0xFFD5C8AB),
    accent: Color(0xFF8A4A1C),
    onAccent: Color(0xFFFFFFFF),
    accentContainer: Color(0xFFEAD6B6),
  );

  static const black = ReaderPalette(
    pageBackground: Color(0xFF000000),
    pageText: Color(0xFFCFCFCF),
    surface: Color(0xFF0E0E0E),
    surfaceVariant: Color(0xFF1B1B1B),
    onSurfaceVariant: Color(0xFF9B9B9B),
    outlineVariant: Color(0xFF2A2A2A),
    accent: Color(0xFFA99BFF),
    onAccent: Color(0xFF000000),
    accentContainer: Color(0xFF1F1A50),
  );

  static const List<ReaderPalette> values = [light, dark, sepia, black];
}
