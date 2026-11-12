import 'package:flutter_test/flutter_test.dart';
import 'package:fusionreflow/data/repositories/text_repository.dart';
import 'package:fusionreflow/data/services/rust_core_service.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../helpers/fake_rust_core_service.dart';

void main() {
  test('RustTextRepository delegates hyphenation to the service', () {
    final service = FakeRustCoreService();
    final repository = RustTextRepository(service);

    expect(repository.hyphenate('слово'), 'hyphenated:слово');
    expect(service.hyphenated, ['слово']);
  });

  test('textRepositoryProvider wires the repository to the service', () {
    final service = FakeRustCoreService();
    final container = ProviderContainer(
      overrides: [rustCoreServiceProvider.overrideWithValue(service)],
    );
    addTearDown(container.dispose);

    final repository = container.read(textRepositoryProvider);

    expect(repository, isA<RustTextRepository>());
    expect(repository.hyphenate('a'), 'hyphenated:a');
    expect(service.hyphenated, ['a']);
  });
}
