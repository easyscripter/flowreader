import 'package:flowreader/data/services/rust_core_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'text_repository.g.dart';

/// Text processing used by the reader (hyphenation, later normalization).
abstract interface class TextRepository {
  /// Returns [text] with soft hyphens inserted at allowed break points.
  String hyphenate(String text);
}

/// [TextRepository] backed by the Rust core.
class RustTextRepository implements TextRepository {
  /// Creates the repository on top of [_service].
  const new(this._service);

  final RustCoreService _service;

  @override
  String hyphenate(String text) => _service.hyphenate(text);
}

/// Provides the app's [TextRepository].
@riverpod
TextRepository textRepository(Ref ref) =>
    RustTextRepository(ref.watch(rustCoreServiceProvider));
