import 'package:flowreader/flow_reader_app.dart';
import 'package:flowreader/src/rust/frb_generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  await RustLib.init();
  runApp(const ProviderScope(child: FlowReaderApp()));
}
