import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fusionreflow/l10n/app_localizations.dart';
import 'package:fusionreflow/ui/spikes/view_models/hyphen_spike_state.dart';
import 'package:fusionreflow/ui/spikes/view_models/hyphen_spike_view_model.dart';
import 'package:fusionreflow/ui/spikes/widgets/spike_paragraph.dart';

/// Debug-only spike 0a screen: soft hyphen rendering and justify quality.
class HyphenSpikeScreen extends ConsumerWidget {
  /// Creates the screen.
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final state = ref.watch(hyphenSpikeViewModelProvider);
    final viewModel = ref.read(hyphenSpikeViewModelProvider.notifier);
    return Scaffold(
      key: const Key('hyphen_spike'),
      appBar: AppBar(title: Text(l10n.spikeHyphenTitle)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(l10n.spikeWidthLabel(state.width.round())),
          Slider(
            key: const Key('spike_width'),
            min: HyphenSpikeState.minWidth,
            max: HyphenSpikeState.maxWidth,
            divisions: (HyphenSpikeState.maxWidth - HyphenSpikeState.minWidth)
                .toInt(),
            value: state.width,
            onChanged: viewModel.setWidth,
          ),
          SwitchListTile(
            key: const Key('spike_justify'),
            title: Text(l10n.spikeJustify),
            value: state.justify,
            onChanged: (justify) => viewModel.setJustify(justify: justify),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.topLeft,
            child: SpikeParagraph(
              text: state.text,
              width: state.width,
              justify: state.justify,
            ),
          ),
        ],
      ),
    );
  }
}
