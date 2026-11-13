import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fusionreflow/ui/core/theme/app_color_schemes.dart';
import 'package:fusionreflow/ui/core/theme/app_theme.dart';

RoundedRectangleBorder _shape(double r) =>
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(r));

void main() {
  final themes = {
    'light': (AppTheme.light(), lightColorScheme),
    'dark': (AppTheme.dark(), darkColorScheme),
  };

  test('light and dark use their schemes', () {
    expect(AppTheme.light().colorScheme, lightColorScheme);
    expect(AppTheme.dark().colorScheme, darkColorScheme);
    for (final (t, s) in themes.values) {
      expect(t.scaffoldBackgroundColor, s.surfaceContainerLowest);
      expect(t.useMaterial3, isTrue);
    }
  });

  test('component themes match design', () {
    for (final entry in themes.entries) {
      final (t, s) = entry.value;
      final r = entry.key;
      expect(
        t.filledButtonTheme.style?.minimumSize?.resolve({}),
        const Size(0, 48),
        reason: r,
      );
      expect(
        t.outlinedButtonTheme.style?.minimumSize?.resolve({}),
        const Size(0, 48),
      );
      expect(
        t.textButtonTheme.style?.minimumSize?.resolve({}),
        const Size(0, 48),
      );
      expect(t.filledButtonTheme.style?.shape?.resolve({}), _shape(8));
      expect(t.outlinedButtonTheme.style?.shape?.resolve({}), _shape(8));
      expect(t.textButtonTheme.style?.shape?.resolve({}), _shape(8));
      expect(
        t.filledButtonTheme.style?.padding?.resolve({}),
        const EdgeInsets.symmetric(horizontal: 24),
      );
      expect(
        t.textButtonTheme.style?.padding?.resolve({}),
        const EdgeInsets.symmetric(horizontal: 12),
      );
      expect(
        t.outlinedButtonTheme.style?.side?.resolve({}),
        BorderSide(color: s.outlineVariant),
      );
      expect(
        t.outlinedButtonTheme.style?.foregroundColor?.resolve({}),
        s.primary,
      );
      expect(t.filledButtonTheme.style?.textStyle?.resolve({})?.fontSize, 15);
      expect(
        t.iconButtonTheme.style?.minimumSize?.resolve({}),
        const Size(48, 48),
      );

      expect(t.chipTheme.shape, _shape(8));
      expect(t.chipTheme.side, BorderSide.none);
      expect(t.chipTheme.backgroundColor, s.surfaceContainerHighest);
      expect(t.chipTheme.selectedColor, s.primaryContainer);
      expect(t.chipTheme.secondaryLabelStyle?.color, s.primary);
      expect(t.chipTheme.labelStyle?.fontSize, 13);
      expect(t.segmentedButtonTheme.style?.shape?.resolve({}), _shape(8));

      final nb = t.navigationBarTheme;
      expect(nb.height, 76);
      expect(nb.backgroundColor, s.surface);
      expect(nb.indicatorColor, s.primaryContainer);
      final label = nb.labelTextStyle;
      expect(label?.resolve({})?.color, s.onSurfaceVariant);
      expect(label?.resolve({WidgetState.selected})?.color, s.primary);
      expect(
        label?.resolve({WidgetState.selected})?.fontWeight,
        FontWeight.w600,
      );
      final nr = t.navigationRailTheme;
      expect(nr.backgroundColor, s.surface);
      expect(nr.minWidth, 96);
      expect(nr.indicatorColor, s.primaryContainer);
      expect(nr.selectedLabelTextStyle?.color, s.primary);
      expect(nr.unselectedLabelTextStyle?.color, s.onSurfaceVariant);

      final fab = t.floatingActionButtonTheme;
      expect(fab.backgroundColor, s.primary);
      expect(fab.foregroundColor, s.onPrimary);
      expect(fab.shape, _shape(16));
      expect(fab.extendedSizeConstraints?.minHeight, 56);
      expect(fab.extendedSizeConstraints?.maxHeight, 56);

      expect(t.dialogTheme.backgroundColor, s.surface);
      expect(t.dialogTheme.shape, _shape(12));

      final bs = t.bottomSheetTheme;
      expect(bs.backgroundColor, s.surface);
      expect(
        bs.shape,
        const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
        ),
      );
      expect(bs.showDragHandle, isTrue);
      expect(bs.dragHandleSize, const Size(32, 4));
      expect(bs.dragHandleColor, s.outlineVariant);

      final sb = t.snackBarTheme;
      expect(sb.backgroundColor, s.inverseSurface);
      expect(sb.contentTextStyle?.color, s.onInverseSurface);
      expect(sb.actionTextColor, s.onInverseSurface);
      expect(sb.shape, _shape(8));
      expect(sb.behavior, SnackBarBehavior.floating);

      final lt = t.listTileTheme;
      expect(lt.minTileHeight, 56);
      expect(lt.shape, _shape(8));
      expect(lt.selectedTileColor, s.primaryContainer);
      expect(lt.selectedColor, s.primary);

      final sl = t.sliderTheme;
      expect(sl.activeTrackColor, s.primary);
      expect(sl.inactiveTrackColor, s.surfaceContainerHighest);
      expect(sl.thumbColor, s.primary);
      expect(sl.trackHeight, 4);

      final sw = t.switchTheme;
      const on = {WidgetState.selected};
      expect(sw.trackColor?.resolve(on), s.primary);
      expect(sw.trackColor?.resolve({}), s.surfaceContainerHighest);
      expect(sw.thumbColor?.resolve(on), s.onPrimary);
      expect(sw.thumbColor?.resolve({}), s.onSurfaceVariant);
      expect(sw.trackOutlineColor?.resolve({}), s.outlineVariant);

      final pi = t.progressIndicatorTheme;
      expect(pi.color, s.primary);
      expect(pi.linearTrackColor, s.surfaceContainerHighest);
      expect(pi.linearMinHeight, 4);

      expect(t.dividerTheme.color, s.outlineVariant);
      expect(t.dividerTheme.thickness, 1);
    }
  });

  test('destructive button uses error colors', () {
    final style = AppTheme.destructiveFilled(lightColorScheme);
    expect(style.backgroundColor?.resolve({}), const Color(0xFFB3261E));
    expect(style.foregroundColor?.resolve({}), const Color(0xFFFFFFFF));
  });

  Widget host(Widget child) => MaterialApp(
    theme: AppTheme.light(),
    home: Scaffold(body: Center(child: child)),
  );

  testWidgets('chip renders 36 high', (tester) async {
    await tester.pumpWidget(
      host(
        ChoiceChip(
          label: const Text('Chip'),
          selected: false,
          onSelected: (_) {},
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ),
    );
    expect(tester.getSize(find.byType(ChoiceChip)).height, 36);
  });

  testWidgets('button renders 48 high', (tester) async {
    await tester.pumpWidget(
      host(FilledButton(onPressed: () {}, child: const Text('OK'))),
    );
    expect(tester.getSize(find.byType(FilledButton)).height, 48);
  });
}
