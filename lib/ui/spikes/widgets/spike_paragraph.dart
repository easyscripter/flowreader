import 'package:flutter/material.dart';
import 'package:fusionreflow/ui/spikes/spike_text.dart';

/// A justified or left-aligned paragraph of fixed [width], used by the spike
/// screen and its golden tests.
class SpikeParagraph extends StatelessWidget {
  /// Creates the paragraph.
  const new({
    required this.text,
    required this.width,
    required this.justify,
    super.key,
  });

  /// Text to show (may contain soft hyphens).
  final String text;

  /// Paragraph width in logical pixels.
  final double width;

  /// Whether the paragraph is justified.
  final bool justify;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      color: Colors.white,
      child: Text(
        text,
        style: kSpikeTextStyle,
        textAlign: justify ? TextAlign.justify : TextAlign.left,
      ),
    );
  }
}
