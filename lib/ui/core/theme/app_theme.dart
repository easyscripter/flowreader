import 'package:flutter/material.dart';
import 'package:fusionreflow/ui/core/theme/app_color_schemes.dart';
import 'package:fusionreflow/ui/core/theme/app_dimens.dart';
import 'package:fusionreflow/ui/core/theme/app_text_theme.dart';

RoundedRectangleBorder _rounded(double radius) =>
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius));

/// Темы приложения: светлая и тёмная. «Системная» — это `ThemeMode.system`.
abstract final class AppTheme {
  static ThemeData light() => _build(lightColorScheme);

  static ThemeData dark() => _build(darkColorScheme);

  /// Стиль сплошной красной кнопки удаления; остальное — из
  /// `filledButtonTheme`.
  static ButtonStyle destructiveFilled(ColorScheme scheme) =>
      FilledButton.styleFrom(
        backgroundColor: scheme.error,
        foregroundColor: scheme.onError,
      );

  static ThemeData _build(ColorScheme s) {
    final text = appTextTheme;
    final control = _rounded(AppRadius.control);
    const minButton = Size(0, AppSizes.buttonHeight);
    final navLabel = WidgetStateProperty.resolveWith<TextStyle?>(
      (states) => states.contains(WidgetState.selected)
          ? text.labelSmall?.copyWith(
              color: s.primary,
              fontWeight: FontWeight.w600,
            )
          : text.labelSmall?.copyWith(color: s.onSurfaceVariant),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: s,
      fontFamily: AppFonts.ui,
      textTheme: text,
      scaffoldBackgroundColor: s.surfaceContainerLowest,
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: minButton,
          shape: control,
          textStyle: text.labelLarge,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s24),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: minButton,
          shape: control,
          textStyle: text.labelLarge,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s24),
          foregroundColor: s.primary,
          side: BorderSide(color: s.outlineVariant),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          minimumSize: minButton,
          shape: control,
          textStyle: text.labelLarge,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s12),
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          minimumSize: const Size.square(AppSizes.touchTarget),
        ),
      ),
      chipTheme: ChipThemeData(
        shape: control,
        side: BorderSide.none,
        backgroundColor: s.surfaceContainerHighest,
        selectedColor: s.primaryContainer,
        labelStyle: text.labelMedium,
        secondaryLabelStyle: text.labelMedium?.copyWith(color: s.primary),
        // Видимая высота = строка подписи + 2 × вертикальный отступ.
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.s8,
          vertical: (AppSizes.chipHeight - 16) / 2,
        ),
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: SegmentedButton.styleFrom(shape: control),
      ),
      navigationBarTheme: NavigationBarThemeData(
        height: AppSizes.navigationBarHeight,
        backgroundColor: s.surface,
        indicatorColor: s.primaryContainer,
        labelTextStyle: navLabel,
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: s.surface,
        minWidth: AppSizes.navigationRailWidth,
        indicatorColor: s.primaryContainer,
        selectedLabelTextStyle: navLabel.resolve({WidgetState.selected}),
        unselectedLabelTextStyle: navLabel.resolve({}),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: s.primary,
        foregroundColor: s.onPrimary,
        shape: _rounded(AppRadius.fab),
        extendedSizeConstraints: const BoxConstraints.tightFor(
          height: AppSizes.fabHeight,
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: s.surface,
        shape: _rounded(AppRadius.dialog),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: s.surface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppRadius.sheet),
          ),
        ),
        showDragHandle: true,
        dragHandleSize: const Size(AppSizes.dragHandleWidth, 4),
        dragHandleColor: s.outlineVariant,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: s.inverseSurface,
        contentTextStyle: text.bodyMedium?.copyWith(color: s.onInverseSurface),
        actionTextColor: s.onInverseSurface,
        shape: control,
        behavior: SnackBarBehavior.floating,
      ),
      listTileTheme: ListTileThemeData(
        minTileHeight: AppSizes.listTileMinHeight,
        shape: control,
        selectedTileColor: s.primaryContainer,
        selectedColor: s.primary,
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: s.primary,
        inactiveTrackColor: s.surfaceContainerHighest,
        thumbColor: s.primary,
        trackHeight: AppSizes.trackHeight,
      ),
      switchTheme: SwitchThemeData(
        trackColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? s.primary
              : s.surfaceContainerHighest,
        ),
        thumbColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? s.onPrimary
              : s.onSurfaceVariant,
        ),
        trackOutlineColor: WidgetStatePropertyAll(s.outlineVariant),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: s.primary,
        linearTrackColor: s.surfaceContainerHighest,
        linearMinHeight: AppSizes.trackHeight,
      ),
      dividerTheme: DividerThemeData(color: s.outlineVariant, thickness: 1),
    );
  }
}
