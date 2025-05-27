import 'dart:collection' show HashMap;
import 'dart:ui' show Locale;

import 'package:string_translate/string_translate.dart'
    show TranslationLocales, StandardTranslations;

Map<String, Map<Locale, String>> _translations = {
  'No unread messages': {
    TranslationLocales.english: 'No unread messages',
    TranslationLocales.german: 'Keine ungelesenen Nachrichten',
  },
  'BBQ Working Time Management': {
    TranslationLocales.english: 'BBQ Working Time Management',
    TranslationLocales.german: 'BBQ Arbeitszeit Management',
  },
  'Login': {
    TranslationLocales.english: 'Login',
    TranslationLocales.german: 'Einloggen',
  },
  'Log into your BBQ work account': {
    TranslationLocales.english: 'Log into your BBQ work account',
    TranslationLocales.german: 'Logge dich bei deinem BBQ Arbeitsaccount ein',
  },
  'Username': {
    TranslationLocales.english: 'Username',
    TranslationLocales.german: 'Nutzername',
  },
  'Password': {
    TranslationLocales.english: 'Password',
    TranslationLocales.german: 'Passwort',
  },
  'Login error': {
    TranslationLocales.english: 'Login error',
    TranslationLocales.german: 'Fehler beim Login',
  },
  // Months
  'January': {
    TranslationLocales.english: 'January',
    TranslationLocales.german: 'Januar',
  },
  'February': {
    TranslationLocales.english: 'February',
    TranslationLocales.german: 'Februar',
  },
  'March': {
    TranslationLocales.english: 'March',
    TranslationLocales.german: 'März',
  },
  'April': {
    TranslationLocales.english: 'April',
    TranslationLocales.german: 'April',
  },
  'May': {TranslationLocales.english: 'May', TranslationLocales.german: 'Mai'},
  'June': {
    TranslationLocales.english: 'June',
    TranslationLocales.german: 'Juni',
  },
  'July': {
    TranslationLocales.english: 'July',
    TranslationLocales.german: 'Juli',
  },
  'August': {
    TranslationLocales.english: 'August',
    TranslationLocales.german: 'August',
  },
  'September': {
    TranslationLocales.english: 'September',
    TranslationLocales.german: 'September',
  },
  'October': {
    TranslationLocales.english: 'October',
    TranslationLocales.german: 'Oktober',
  },
  'November': {
    TranslationLocales.english: 'November',
    TranslationLocales.german: 'November',
  },
  'December': {
    TranslationLocales.english: 'December',
    TranslationLocales.german: 'Dezember',
  },
};

HashMap<String, Map<Locale, String>> get translations {
  HashMap<String, Map<Locale, String>> local = HashMap.from(_translations);
  local.addAll(HashMap.from(StandardTranslations.all));
  return local;
}