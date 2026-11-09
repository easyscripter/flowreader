import 'package:flowreader/l10n/app_localizations.dart';
import 'package:flowreader/ui/home/widgets/home_screen.dart';
import 'package:flutter/material.dart';

class FlowReaderApp extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      home: const HomeScreen(),
    );
  }
}
