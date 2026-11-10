import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fusionreflow/data/repositories/text_repository.dart';
import 'package:fusionreflow/ui/spikes/spike_text.dart';
import 'package:fusionreflow/ui/spikes/view_models/hyphen_spike_state.dart';
import 'package:fusionreflow/ui/spikes/view_models/hyphen_spike_view_model.dart';

class _FakeTextRepository implements TextRepository {
  @override
  String hyphenate(String text) => '[$text]';
}

ProviderContainer _container() {
  final container = ProviderContainer(
    overrides: [
      textRepositoryProvider.overrideWithValue(_FakeTextRepository()),
    ],
  );
  addTearDown(container.dispose);
  return container;
}

void main() {
  test('initial state hyphenates the sample paragraph via the repository', () {
    final state = _container().read(hyphenSpikeViewModelProvider);

    expect(state.text, '[$kSpikeSource]');
    expect(state.width, HyphenSpikeState.defaultWidth);
    expect(state.justify, isTrue);
  });

  test('setWidth stores the width and clamps it to the supported range', () {
    final container = _container();
    HyphenSpikeViewModel viewModel() =>
        container.read(hyphenSpikeViewModelProvider.notifier);

    viewModel().setWidth(300);
    expect(container.read(hyphenSpikeViewModelProvider).width, 300);

    viewModel().setWidth(10);
    expect(
      container.read(hyphenSpikeViewModelProvider).width,
      HyphenSpikeState.minWidth,
    );

    viewModel().setWidth(10000);
    expect(
      container.read(hyphenSpikeViewModelProvider).width,
      HyphenSpikeState.maxWidth,
    );
  });

  test('setJustify switches the alignment', () {
    final container = _container();

    container
        .read(hyphenSpikeViewModelProvider.notifier)
        .setJustify(justify: false);

    expect(container.read(hyphenSpikeViewModelProvider).justify, isFalse);
  });
}
