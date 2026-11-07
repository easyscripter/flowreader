import 'package:flowreader/l10n/app_localizations.dart';
import 'package:flowreader/spikes/hyphen_spike_screen.dart';
import 'package:flutter/foundation.dart';
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
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(l10n.appTitle),
            // Debug builds only: spike 0a (soft hyphen rendering).
            if (kDebugMode)
              TextButton(
                key: const Key('open_hyphen_spike'),
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => const HyphenSpikeScreen(),
                  ),
                ),
                child: Text(l10n.spikeOpenButton),
              ),
          ],
        ),
      ),
    );
  }
}
