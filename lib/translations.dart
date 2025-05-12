import 'dart:collection';
import 'dart:ui';

import 'package:string_translate/string_translate.dart'
    show TranslationLocales, StandardTranslations;

Map<String, Map<Locale, String>> _translations = {
  "No unread messages": {
    TranslationLocales.english: "No unread messages",
    TranslationLocales.german: "Keine ungelesenen Nachrichten",
  },
  "BBQ Working Time Management": {
    TranslationLocales.english: "BBQ Working Time Management",
    TranslationLocales.german: "BBQ Arbeitszeit Management",
  },
  "Login": {
    TranslationLocales.english: "Login",
    TranslationLocales.german: "Einloggen",
  },
  "Log into your BBQ work account": {
    TranslationLocales.english: "Log into your BBQ work account",
    TranslationLocales.german: "Logge dich bei deinem BBQ Arbeitsaccount ein",
  },
  "Username": {
    TranslationLocales.english: "Username",
    TranslationLocales.german: "Username",
  },
  "Password": {
    TranslationLocales.english: "Password",
    TranslationLocales.german: "Passwort",
  },
};

HashMap<String, Map<Locale, String>> get translations {
  HashMap<String, Map<Locale, String>> local = HashMap.from(_translations);
  local.addAll(HashMap.from(StandardTranslations.all));
  return local;
}
