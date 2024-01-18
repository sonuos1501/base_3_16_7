// ignore_for_file: prefer_final_locals, avoid_field_initializers_in_const_classes, avoid_catches_without_on_clauses

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../models/language/Language.dart';
import '../custom_log/custom_log.dart';

// supported languages
final List<Language> supportedLanguages = [
  Language(code: 'US', locale: 'en', language: 'English'),
  Language(code: 'KR', locale: 'ko', language: 'Korean'),
  // Language(code: 'VN', locale: 'vi', language: 'Vietnamese'),
];

class AppLocalizations {
  // constructor
  AppLocalizations(this.locale);
  // localization variables
  final Locale locale;
  late Map<String, String> localizedStrings;

  // Static member to have a simple access to the delegate from the MaterialApp
  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  // Helper method to keep the code in the widgets concise
  // Localizations are accessed using an InheritedWidget "of" syntax
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  // This is a helper method that will load local specific strings from file
  // present in lang folder
  Future<bool> load() async {
    // Load the language JSON file from the "lang" folder
    final jsonString =
        await rootBundle.loadString('assets/lang/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    localizedStrings = jsonMap.map((key, value) {
      return MapEntry(
        key,
        value.toString().replaceAll(r"\'", "'").replaceAll(r'\t', ' '),
      );
    });

    return true;
  }

  // This method will be called from every widget which needs a localized text
  String translate(String key) {
    return localizedStrings[key]!;
  }
}

// LocalizationsDelegate is a factory for a set of localized resources
// In this case, the localized strings will be gotten in an AppLocalizations object
class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  // This delegate instance will never change (it doesn't even have fields!)
  // It can provide a constant constructor.
  const _AppLocalizationsDelegate();
  // ignore: non_constant_identifier_names
  final String TAG = 'AppLocalizations';

  @override
  bool isSupported(Locale locale) {
    // Include all of your supported language codes here
    return supportedLanguages
        .map((e) => e.locale)
        .toList()
        .contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    // AppLocalizations class is where the JSON loading actually runs
    final localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

extension Trans on String {
  String tr(BuildContext context) {
    try {
      return AppLocalizations.of(context).translate(this);
    } catch (e) {
      logError(e.toString());
      return this;
    }
  }
}
