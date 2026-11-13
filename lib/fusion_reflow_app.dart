import 'package:flutter/material.dart';
import 'package:fusionreflow/l10n/app_localizations.dart';
import 'package:fusionreflow/ui/core/theme/app_theme.dart';
import 'package:fusionreflow/ui/home/widgets/home_screen.dart';

class FusionReflowApp extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      // ignore: avoid_redundant_argument_values (режим «системная» — явно)
      themeMode: ThemeMode.system,
      home: const HomeScreen(),
    );
  }
}
