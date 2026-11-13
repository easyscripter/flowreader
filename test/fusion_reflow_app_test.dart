import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fusionreflow/fusion_reflow_app.dart';

void main() {
  testWidgets('app uses both themes and system mode', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: FusionReflowApp()));
    final app = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(app.theme?.colorScheme.primary, const Color(0xFF4A3FD0));
    expect(app.darkTheme?.colorScheme.primary, const Color(0xFFA99BFF));
    expect(app.themeMode, ThemeMode.system);
  });
}
