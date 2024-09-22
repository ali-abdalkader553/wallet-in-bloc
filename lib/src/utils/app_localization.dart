import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  final Locale? locale;

  AppLocalizations({required this.locale});

  //لحتى يعرف انو عم يترجم
  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static LocalizationsDelegate<AppLocalizations> delegate =
      AppLocalizationDelegate();

  late Map<String, String> jsonStrings;

  Future loadLangjson() async {
    String strings = await rootBundle
        .loadString('assets/languages/${locale!.languageCode}.json');
    Map<String, dynamic> jsons = json.decode(strings);
    jsonStrings = jsons.map((key, value) {
      return MapEntry(key, value.toString());
    });
  }

  String translate(String key) => jsonStrings[key] ?? "";
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalizations> {
  @override
  bool isSupported(Locale locale) {
    // TODO: implement isSupported
    return ['en', 'ar'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    // TODO: implement load
    AppLocalizations appLocalizations = AppLocalizations(locale: locale);
    await appLocalizations.loadLangjson();
    return appLocalizations;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) =>
      false;
}
