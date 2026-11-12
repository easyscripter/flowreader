import 'dart:typed_data';

import 'package:fusionreflow/data/services/rust_core_service.dart';
import 'package:fusionreflow/src/rust/api/book.dart';

/// Bytes that [FakeRustCoreService.bookMeta] rejects like a corrupt book.
final Uint8List badBookBytes = Uint8List.fromList([0xFF]);

/// Bridge-free [RustCoreService]: bytes `[n]` describe book `n`
/// (`title 'T$n'`, `sourceHash 'h$n'`); [badBookBytes] throw a `FormatError`.
class FakeRustCoreService implements RustCoreService {
  /// Texts passed to [hyphenate].
  final List<String> hyphenated = [];

  @override
  String hyphenate(String text) {
    hyphenated.add(text);
    return 'hyphenated:$text';
  }

  @override
  Future<BookMeta> bookMeta(Uint8List bytes) async {
    final n = bytes.first;
    if (n == 0xFF) throw const FormatError.corrupt('bad bytes');
    return BookMeta(
      title: 'T$n',
      authors: ['A$n'],
      sourceHash: 'h$n',
      converterVersion: 'test',
    );
  }
}
