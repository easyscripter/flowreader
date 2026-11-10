import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fusionreflow/fusion_reflow_app.dart';

void main() {
  testWidgets('app starts and shows the home screen', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: FusionReflowApp()));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('home')), findsOneWidget);
    expect(find.text('FusionReflow'), findsWidgets);
  });
}
