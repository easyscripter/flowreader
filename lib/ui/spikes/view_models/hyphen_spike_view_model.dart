import 'package:flowreader/data/repositories/text_repository.dart';
import 'package:flowreader/ui/spikes/spike_text.dart';
import 'package:flowreader/ui/spikes/view_models/hyphen_spike_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'hyphen_spike_view_model.g.dart';

/// ViewModel of the hyphenation spike screen: hyphenates the sample paragraph
/// once and holds the width / alignment chosen by the user.
@riverpod
class HyphenSpikeViewModel extends _$HyphenSpikeViewModel {
  @override
  HyphenSpikeState build() => HyphenSpikeState(
    text: ref.watch(textRepositoryProvider).hyphenate(kSpikeSource),
  );

  /// Sets the paragraph width, clamped to the supported range.
  void setWidth(double width) {
    state = state.copyWith(
      width: width.clamp(HyphenSpikeState.minWidth, HyphenSpikeState.maxWidth),
    );
  }

  /// Switches between justified and left-aligned text.
  void setJustify({required bool justify}) {
    state = state.copyWith(justify: justify);
  }
}
