import 'dart:io';

import 'package:flowreader/ui/spikes/spike_text.dart';
import 'package:flowreader/ui/spikes/widgets/spike_paragraph.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

const _softHyphen = '\u00AD';

Future<void> _loadLiterata() async {
  final loader = FontLoader(kSpikeFontFamily)
    ..addFont(
      Future.value(
        ByteData.sublistView(
          File('assets/fonts/literata/Literata-Regular.ttf').readAsBytesSync(),
        ),
      ),
    );
  await loader.load();
}

TextPainter _layout(double width) {
  final painter = TextPainter(
    text: const TextSpan(text: kSpikeHyphenated, style: kSpikeTextStyle),
    textAlign: TextAlign.justify,
    textDirection: TextDirection.ltr,
  )..layout(maxWidth: width);
  return painter;
}

void main() {
  setUpAll(_loadLiterata);

  test('fixture contains soft hyphens', () {
    expect(kSpikeHyphenated.contains(_softHyphen), isTrue);
  });

  test('breaks_at_soft_hyphen', () {
    final painter = _layout(280);
    final lines = painter.computeLineMetrics();
    expect(lines.length, greaterThan(3));

    var hyphenBreaks = 0;
    for (final line in lines) {
      final y = line.baseline - line.ascent / 2;
      final pos = painter.getPositionForOffset(Offset(1, y));
      final end = painter.getLineBoundary(pos).end;
      if (end > 0 &&
          end <= kSpikeHyphenated.length &&
          kSpikeHyphenated[end - 1] == _softHyphen) {
        hyphenBreaks++;
      }
    }
    // Spike evidence: the break count is part of the 0a report.
    // ignore: avoid_print
    print('lines=${lines.length} hyphenBreaks=$hyphenBreaks');
    expect(hyphenBreaks, greaterThan(0));
  });

  for (final width in [280.0, 360.0]) {
    testWidgets('golden at ${width.toInt()}', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            backgroundColor: Colors.white,
            body: Align(
              alignment: Alignment.topLeft,
              child: RepaintBoundary(
                key: const Key('paragraph'),
                child: SpikeParagraph(
                  text: kSpikeHyphenated,
                  width: width,
                  justify: true,
                ),
              ),
            ),
          ),
        ),
      );
      await expectLater(
        find.byKey(const Key('paragraph')),
        matchesGoldenFile('goldens/hyphen_${width.toInt()}.png'),
      );
    });
  }
}
