import 'dart:ui';

Locale findLocale(Locale locale, List<Locale> supportedLocales) {
  for (final supportedLocale in supportedLocales) {
    if (supportedLocale.languageCode == locale.languageCode &&
        supportedLocale.countryCode == locale.countryCode) {
      return supportedLocale;
    }
  }
  return supportedLocales.first;
}

const supportedLocales = [Locale('en', 'US')];
