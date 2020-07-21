import 'package:flutter/cupertino.dart';

class SupportedLanguages {
  static List<Locale> getSupportedLanguages() {
    return [
      Locale('en', 'US'),
      Locale('it', 'IT'),
    ];
  }

  static List<String> getSupportedLanguagesCodes() {
    return getSupportedLanguages().map((e) => e.languageCode).toList();
  }
}
