import 'package:freezed_annotation/freezed_annotation.dart';

part 'hyphen_spike_state.freezed.dart';

/// UI state of the hyphenation spike screen.
@freezed
abstract class HyphenSpikeState with _$HyphenSpikeState {
  /// Creates the state: [text] with soft hyphens, paragraph [width] in
  /// logical pixels, and whether the paragraph is [justify]-aligned.
  const factory({
    required String text,
    @Default(HyphenSpikeState.defaultWidth) double width,
    @Default(true) bool justify,
  }) = _HyphenSpikeState;

  /// Narrowest paragraph width offered by the screen.
  static const double minWidth = 200;

  /// Widest paragraph width offered by the screen.
  static const double maxWidth = 360;

  /// Initial paragraph width.
  static const double defaultWidth = 280;
}
