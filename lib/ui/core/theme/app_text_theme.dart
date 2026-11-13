import 'package:flutter/material.dart';

/// Семейства шрифтов приложения.
abstract final class AppFonts {
  static const ui = 'GolosText';
  static const book = 'Literata';
}

TextStyle _style(
  double size,
  double lineHeight,
  FontWeight weight, [
  double letterSpacing = 0,
]) => TextStyle(
  fontFamily: AppFonts.ui,
  fontSize: size,
  height: lineHeight / size,
  fontWeight: weight,
  letterSpacing: letterSpacing,
);

/// Шкала интерфейса. Цвета проставляет `ThemeData` из `onSurface`.
/// Вес вариативного шрифта выставляется осью `wght` по значению
/// `FontWeight`.
final TextTheme appTextTheme = TextTheme(
  headlineLarge: _style(32, 40, const FontWeight(650), -0.64),
  headlineMedium: _style(26, 32, const FontWeight(650), -0.52),
  titleLarge: _style(20, 28, const FontWeight(650)),
  titleMedium: _style(16, 24, FontWeight.w600),
  titleSmall: _style(14, 20, FontWeight.w600),
  bodyLarge: _style(16, 24, FontWeight.w400),
  bodyMedium: _style(15, 22, FontWeight.w400),
  bodySmall: _style(13, 18, FontWeight.w400),
  labelLarge: _style(15, 20, FontWeight.w600),
  labelMedium: _style(13, 16, const FontWeight(550)),
  labelSmall: _style(12, 16, FontWeight.w500),
);
