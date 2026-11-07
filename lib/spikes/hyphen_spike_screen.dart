import 'package:flowreader/l10n/app_localizations.dart';
import 'package:flowreader/spikes/spike_text.dart';
import 'package:flowreader/src/rust/api/text.dart' as rust_text;
import 'package:flutter/material.dart';

/// A justified/left paragraph of fixed [width], used by the screen and goldens.
class SpikeParagraph extends StatelessWidget {
  const SpikeParagraph({
    required this.text,
    required this.width,
    required this.justify,
    super.key,
  });

  final String text;
  final double width;
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

/// Debug-only spike 0a screen: soft hyphen rendering and justify quality.
class HyphenSpikeScreen extends StatefulWidget {
  const HyphenSpikeScreen({this.text, super.key});

  /// Pre-hyphenated text; when null the paragraph is hyphenated live through
  /// the Rust bridge.
  final String? text;

  @override
  State<HyphenSpikeScreen> createState() => _HyphenSpikeScreenState();
}

class _HyphenSpikeScreenState extends State<HyphenSpikeScreen> {
  late final String _text =
      widget.text ?? rust_text.hyphenate(text: kSpikeSource);
  double _width = 280;
  bool _justify = true;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      key: const Key('hyphen_spike'),
      appBar: AppBar(title: Text(l10n.spikeHyphenTitle)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(l10n.spikeWidthLabel(_width.round())),
          Slider(
            key: const Key('spike_width'),
            min: 200,
            max: 360,
            divisions: 160,
            value: _width,
            onChanged: (v) => setState(() => _width = v),
          ),
          SwitchListTile(
            key: const Key('spike_justify'),
            title: Text(l10n.spikeJustify),
            value: _justify,
            onChanged: (v) => setState(() => _justify = v),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.topLeft,
            child: SpikeParagraph(
              text: _text,
              width: _width,
              justify: _justify,
            ),
          ),
        ],
      ),
    );
  }
}
