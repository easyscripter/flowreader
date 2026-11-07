// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'FlowReader';

  @override
  String get spikeHyphenTitle => 'Soft hyphen spike';

  @override
  String spikeWidthLabel(int width) {
    return 'Width: $width px';
  }

  @override
  String get spikeJustify => 'Justify text';

  @override
  String get spikeOpenButton => 'Hyphenation spike (debug)';
}
