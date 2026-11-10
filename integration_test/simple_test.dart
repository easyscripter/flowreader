import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fusionreflow/fusion_reflow_app.dart';
import 'package:fusionreflow/src/rust/api/simple.dart';
import 'package:fusionreflow/src/rust/frb_generated.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(RustLib.init);
  testWidgets('Rust bridge is callable and app starts', (tester) async {
    expect(greet(name: 'Tom'), 'Hello, Tom!');
    await tester.pumpWidget(const ProviderScope(child: FusionReflowApp()));
    expect(find.byKey(const Key('home')), findsOneWidget);
  });
}
