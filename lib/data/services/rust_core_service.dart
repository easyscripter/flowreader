import 'package:flowreader/src/rust/api/text.dart' as rust_text;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'rust_core_service.g.dart';

/// Thin, stateless wrapper over the Rust core bridge.
///
/// The only place in the app that talks to the generated bridge code
/// (`lib/src/rust/**`); repositories depend on this service instead.
class RustCoreService {
  /// Creates the service.
  const new();

  /// Inserts soft hyphens (U+00AD) at allowed break points of ru/en words.
  String hyphenate(String text) => rust_text.hyphenate(text: text);
}

/// Provides the [RustCoreService].
@riverpod
RustCoreService rustCoreService(Ref ref) => const RustCoreService();
