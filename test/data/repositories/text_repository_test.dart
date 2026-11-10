import 'package:flutter_test/flutter_test.dart';
import 'package:fusionreflow/data/repositories/text_repository.dart';
import 'package:fusionreflow/data/services/rust_core_service.dart';

class _FakeRustCoreService implements RustCoreService {
  final List<String> calls = [];

  @override
  String hyphenate(String text) {
    calls.add(text);
    return 'hyphenated:$text';
  }
}

void main() {
  test('RustTextRepository delegates hyphenation to the service', () {
    final service = _FakeRustCoreService();
    final repository = RustTextRepository(service);

    expect(repository.hyphenate('слово'), 'hyphenated:слово');
    expect(service.calls, ['слово']);
  });
}
