import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fusionreflow/fusion_reflow_app.dart';
import 'package:fusionreflow/src/rust/frb_generated.dart';
import 'package:integration_test/integration_test.dart';

/// Spike 0a on a device: live Rust hyphenation + Flutter text engine.
/// Run: flutter drive --driver=test_driver/integration_test.dart
///   --target=integration_test/hyphen_spike_device_test.dart -d `<id>` --flavor store
void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(RustLib.init);

  testWidgets('hyphen spike screenshots', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: FusionReflowApp()));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('open_hyphen_spike')));
    await tester.pumpAndSettle();
    await binding.convertFlutterSurfaceToImage();
    await tester.pumpAndSettle();

    final slider = find.byKey(const Key('spike_width'));
    final track = tester.getRect(slider);
    // Slider range is 200..360, so x(w) = left + (w - 200) / 160 * width
    // (track insets are small relative to the check; verified via label text).
    Future<void> setWidth(int w) async {
      final widget = tester.widget<Slider>(slider);
      widget.onChanged!(w.toDouble());
      await tester.pumpAndSettle();
      expect(find.textContaining('$w px'), findsOneWidget);
    }

    expect(track.width, greaterThan(0));
    for (final w in [280, 360]) {
      await setWidth(w);
      await binding.takeScreenshot('device_justify_$w');
    }
    await setWidth(280);
    await tester.tap(find.byKey(const Key('spike_justify')));
    await tester.pumpAndSettle();
    await binding.takeScreenshot('device_left_280');
  });
}
