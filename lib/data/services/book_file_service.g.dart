// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_file_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provides the [BookFileService] rooted in the app support directory.

@ProviderFor(bookFileService)
final bookFileServiceProvider = BookFileServiceProvider._();

/// Provides the [BookFileService] rooted in the app support directory.

final class BookFileServiceProvider
    extends
        $FunctionalProvider<BookFileService, BookFileService, BookFileService>
    with $Provider<BookFileService> {
  /// Provides the [BookFileService] rooted in the app support directory.
  BookFileServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bookFileServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bookFileServiceHash();

  @$internal
  @override
  $ProviderElement<BookFileService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  BookFileService create(Ref ref) {
    return bookFileService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BookFileService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BookFileService>(value),
    );
  }
}

String _$bookFileServiceHash() => r'd877d757016f788002331e0c0bc378f1fb1585f6';
