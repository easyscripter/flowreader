import 'package:flowreader/app.dart';
import 'package:flowreader/src/rust/api/simple.dart';
import 'package:flowreader/src/rust/frb_generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async => await RustLib.init());
  testWidgets('Rust bridge is callable and app starts', (tester) async {
    expect(greet(name: 'Tom'), 'Hello, Tom!');
    await tester.pumpWidget(const FlowReaderApp());
    expect(find.byKey(const Key('home')), findsOneWidget);
  });
}
