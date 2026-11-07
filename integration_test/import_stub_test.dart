import 'dart:io';

import 'package:flowreader/src/rust/api/import.dart';
import 'package:flowreader/src/rust/frb_generated.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

Future<int> _tempFd() async {
  final dir = await Directory.systemTemp.createTemp('import_stub');
  final f = File('${dir.path}/src.pdf')..writeAsBytesSync([0x25, 0x50, 0x44, 0x46]);
  return debugOpenFd(path: f.path);
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async => await RustLib.init());

  testWidgets('stub: Started, 3x Progress, Failed(Unsupported)', (t) async {
    final events =
        await importBook(fd: await _tempFd(), kind: SourceKind.pdf).toList();
    expect(events.first, isA<ImportEvent_Started>());
    final progress = events.whereType<ImportEvent_Progress>().toList();
    expect(progress.length, 3);
    for (var i = 0; i < 3; i++) {
      final p = progress[i].field0;
      expect(p.stage, Stage.pages);
      expect(p.done, i + 1);
      expect(p.total, 3);
    }
    final last = events.last;
    expect(last, isA<ImportEvent_Failed>());
    expect((last as ImportEvent_Failed).field0,
        const ImportError.unsupported(SourceKind.pdf));
    expect(events.length, 5);
  });

  testWidgets('cancel after first Progress -> Failed(Cancelled), stream closes',
      (t) async {
    final events = <ImportEvent>[];
    var jobId = -1;
    var cancelled = false;
    await for (final e in importBook(fd: await _tempFd(), kind: SourceKind.pdf)) {
      events.add(e);
      if (e is ImportEvent_Started) jobId = e.field0;
      if (e is ImportEvent_Progress && !cancelled) {
        cancelled = true;
        cancelImport(jobId: jobId);
      }
    }
    expect(events.whereType<ImportEvent_Progress>().length, 1);
    expect(events.last, isA<ImportEvent_Failed>());
    expect((events.last as ImportEvent_Failed).field0,
        const ImportError.cancelled());
  });
}
