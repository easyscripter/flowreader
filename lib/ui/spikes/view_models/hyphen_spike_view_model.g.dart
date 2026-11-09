// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hyphen_spike_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// ViewModel of the hyphenation spike screen: hyphenates the sample paragraph
/// once and holds the width / alignment chosen by the user.

@ProviderFor(HyphenSpikeViewModel)
final hyphenSpikeViewModelProvider = HyphenSpikeViewModelProvider._();

/// ViewModel of the hyphenation spike screen: hyphenates the sample paragraph
/// once and holds the width / alignment chosen by the user.
final class HyphenSpikeViewModelProvider
    extends $NotifierProvider<HyphenSpikeViewModel, HyphenSpikeState> {
  /// ViewModel of the hyphenation spike screen: hyphenates the sample paragraph
  /// once and holds the width / alignment chosen by the user.
  HyphenSpikeViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'hyphenSpikeViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$hyphenSpikeViewModelHash();

  @$internal
  @override
  HyphenSpikeViewModel create() => HyphenSpikeViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HyphenSpikeState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HyphenSpikeState>(value),
    );
  }
}

String _$hyphenSpikeViewModelHash() =>
    r'0963aeb12e75c7e0f9fa92c57ca2ef861cb26864';

/// ViewModel of the hyphenation spike screen: hyphenates the sample paragraph
/// once and holds the width / alignment chosen by the user.

abstract class _$HyphenSpikeViewModel extends $Notifier<HyphenSpikeState> {
  HyphenSpikeState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<HyphenSpikeState, HyphenSpikeState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<HyphenSpikeState, HyphenSpikeState>,
              HyphenSpikeState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
