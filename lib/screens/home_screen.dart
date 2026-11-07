import 'package:flowreader/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

/// Placeholder home screen; replaced by the library screen in later tasks.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      key: const Key('home'),
      appBar: AppBar(title: Text(l10n.appTitle)),
      body: Center(child: Text(l10n.appTitle)),
    );
  }
}
