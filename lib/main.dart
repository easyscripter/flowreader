import 'package:flowreader/app.dart';
import 'package:flowreader/src/rust/frb_generated.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  await RustLib.init();
  runApp(const FlowReaderApp());
}
