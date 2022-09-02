import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

const String langCode = 'languageCode';

//languages code
const String english = 'en';
const String arabic = 'ar';
const String hindi = 'hi';
const String swahili = 'sw';
const String chinese = 'zh';

Future<Locale> setLocale(String languageCode) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(langCode, languageCode);
  return _locale(languageCode);
}

Future<Locale> getLocale() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String languageCode = _prefs.getString(langCode) ?? english;
  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  switch (languageCode) {
    case english:
      return const Locale(english, '');
    case swahili:
      return const Locale(swahili, "");
    case arabic:
      return const Locale(arabic, "");
    case hindi:
      return const Locale(hindi, "");
    case chinese:
      return const Locale(chinese, "");

    default:
      return const Locale(english, '');
  }
}

AppLocalizations translation(BuildContext context) {
  return AppLocalizations.of(context)!;
}
