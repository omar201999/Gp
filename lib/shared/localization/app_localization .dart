
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  final Locale locale;
   late Map<String,String> _localizedStrings;
  static LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelgate();

  AppLocalizations({
    required this.locale,
  });

  static AppLocalizations of(BuildContext context) =>
      Localizations.of(context, AppLocalizations);

  Future load() async {
    String jsonString = await rootBundle.loadString('assets/translation/${locale.languageCode}.json');
    Map<String,dynamic> jsonMap = json.decode(jsonString);
    _localizedStrings = jsonMap.map((key, value) => MapEntry(key, value));
  }

  String translate(String key) {
    return _localizedStrings[key]??"";
  }
}

class _AppLocalizationsDelgate
    extends LocalizationsDelegate<AppLocalizations> {
  @override
  bool isSupported(Locale locale) {
    return ['en','ar'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = AppLocalizations(locale: locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) => false;
}