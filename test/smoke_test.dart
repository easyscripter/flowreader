import 'package:flowreader/flow_reader_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('app starts and shows the home screen', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: FlowReaderApp()));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('home')), findsOneWidget);
    expect(find.text('FlowReader'), findsWidgets);
  });
}
