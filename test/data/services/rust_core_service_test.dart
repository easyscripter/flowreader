import 'package:flutter_test/flutter_test.dart';
import 'package:fusionreflow/data/services/rust_core_service.dart';
import 'package:fusionreflow/src/rust/frb_generated.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

/// Bridge API double: only hyphenation is implemented, anything else fails.
class _FakeRustLibApi implements RustLibApi {
  final List<String> hyphenated = [];

  @override
  String crateApiTextHyphenate({required String text}) {
    hyphenated.add(text);
    return 'bridge:$text';
  }

  @override
  dynamic noSuchMethod(Invocation invocation) =>
      throw UnimplementedError('${invocation.memberName} is not faked');
}

void main() {
  late _FakeRustLibApi api;

  setUp(() {
    api = _FakeRustLibApi();
    RustLib.initMock(api: api);
  });

  tearDown(RustLib.dispose);

  test('RustCoreService.hyphenate calls the bridge with the text', () {
    const service = RustCoreService();

    expect(service.hyphenate('слово'), 'bridge:слово');
    expect(api.hyphenated, ['слово']);
  });

  test('rustCoreServiceProvider provides a RustCoreService', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    expect(container.read(rustCoreServiceProvider), isA<RustCoreService>());
  });
}
