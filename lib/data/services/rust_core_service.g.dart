// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rust_core_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provides the [RustCoreService].

@ProviderFor(rustCoreService)
final rustCoreServiceProvider = RustCoreServiceProvider._();

/// Provides the [RustCoreService].

final class RustCoreServiceProvider
    extends
        $FunctionalProvider<RustCoreService, RustCoreService, RustCoreService>
    with $Provider<RustCoreService> {
  /// Provides the [RustCoreService].
  RustCoreServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'rustCoreServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$rustCoreServiceHash();

  @$internal
  @override
  $ProviderElement<RustCoreService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  RustCoreService create(Ref ref) {
    return rustCoreService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RustCoreService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RustCoreService>(value),
    );
  }
}

String _$rustCoreServiceHash() => r'908905dc630780162862a3ef41fd1c0d71ce890c';
