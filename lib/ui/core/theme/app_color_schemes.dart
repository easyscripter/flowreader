import 'package:flutter/material.dart';

// Роли, которых нет в дизайне, один раз сгенерированы через
// ColorScheme.fromSeed(seedColor: primary темы) и записаны литералами.
// Исключение: surfaceContainerLow/-/High подобраны в ряд палитры дизайна
// между surfaceContainerLowest и surfaceContainerHighest (решение человека).

/// Светлая тема приложения.
const ColorScheme lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF4A3FD0),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFFE9E7FB),
  onPrimaryContainer: Color(0xFF4A3FD0),
  secondary: Color(0xFF5E5C71),
  onSecondary: Color(0xFFFFFFFF),
  // Тональная кнопка, выбранный чип и индикатор NavigationBar берут
  // secondaryContainer, а в дизайне они фиолетовые.
  secondaryContainer: Color(0xFFE9E7FB),
  onSecondaryContainer: Color(0xFF4A3FD0),
  tertiary: Color(0xFF0E7C86),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFFFD8EA),
  onTertiaryContainer: Color(0xFF603B4F),
  error: Color(0xFFB3261E),
  onError: Color(0xFFFFFFFF),
  errorContainer: Color(0xFFFFDAD6),
  onErrorContainer: Color(0xFF93000A),
  surface: Color(0xFFFFFFFF),
  onSurface: Color(0xFF12142A),
  onSurfaceVariant: Color(0xFF565A75),
  outline: Color(0xFF787680),
  outlineVariant: Color(0xFFDCDDE8),
  shadow: Color(0xFF000000),
  scrim: Color(0xFF000000),
  inverseSurface: Color(0xFF12142A),
  onInverseSurface: Color(0xFFF4F4F9),
  inversePrimary: Color(0xFFC4C0FF),
  // Тональной заливки по высоте нет: тени только у листа и диалога.
  surfaceTint: Colors.transparent,
  surfaceContainerLowest: Color(0xFFF4F4F9),
  surfaceContainerLow: Color(0xFFF1F2F8),
  surfaceContainer: Color(0xFFEFF0F6),
  surfaceContainerHigh: Color(0xFFEDEEF5),
  surfaceContainerHighest: Color(0xFFEAEBF3),
);

/// Тёмная тема приложения.
const ColorScheme darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFFA99BFF),
  onPrimary: Color(0xFF120C3A),
  primaryContainer: Color(0xFF2B2570),
  onPrimaryContainer: Color(0xFFA99BFF),
  secondary: Color(0xFFC9C3DC),
  onSecondary: Color(0xFF312E41),
  secondaryContainer: Color(0xFF2B2570),
  onSecondaryContainer: Color(0xFFA99BFF),
  tertiary: Color(0xFF3CD6D0),
  onTertiary: Color(0xFF482536),
  tertiaryContainer: Color(0xFF613B4C),
  onTertiaryContainer: Color(0xFFFFD8E7),
  error: Color(0xFFFF8A80),
  onError: Color(0xFF120C3A),
  errorContainer: Color(0xFF93000A),
  onErrorContainer: Color(0xFFFFDAD6),
  surface: Color(0xFF12162E),
  onSurface: Color(0xFFEEF0FF),
  onSurfaceVariant: Color(0xFFA0A6CC),
  outline: Color(0xFF938F99),
  outlineVariant: Color(0xFF262B58),
  shadow: Color(0xFF000000),
  scrim: Color(0xFF000000),
  inverseSurface: Color(0xFFEEF0FF),
  onInverseSurface: Color(0xFF0C0F22),
  inversePrimary: Color(0xFF5F5791),
  surfaceTint: Colors.transparent,
  surfaceContainerLowest: Color(0xFF0C0F22),
  surfaceContainerLow: Color(0xFF0F1328),
  surfaceContainer: Color(0xFF12162E),
  surfaceContainerHigh: Color(0xFF171C3B),
  surfaceContainerHighest: Color(0xFF1C2144),
);
