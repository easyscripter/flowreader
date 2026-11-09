// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provides the app's [TextRepository].

@ProviderFor(textRepository)
final textRepositoryProvider = TextRepositoryProvider._();

/// Provides the app's [TextRepository].

final class TextRepositoryProvider
    extends $FunctionalProvider<TextRepository, TextRepository, TextRepository>
    with $Provider<TextRepository> {
  /// Provides the app's [TextRepository].
  TextRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'textRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$textRepositoryHash();

  @$internal
  @override
  $ProviderElement<TextRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TextRepository create(Ref ref) {
    return textRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TextRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TextRepository>(value),
    );
  }
}

String _$textRepositoryHash() => r'e56ede08e1723863bf029ae90224b72fabb42009';
