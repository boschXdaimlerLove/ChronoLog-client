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
  'Log in': {
    TranslationLocales.english: 'Log in',
    TranslationLocales.german: 'Einloggen',
  },
  'Log out': {
    TranslationLocales.english: 'Log out',
    TranslationLocales.german: 'Ausloggen',
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
  ' Monday': {
    TranslationLocales.english: ' Monday',
    TranslationLocales.german: ' Montag',
  },
  '  Tuesday': {
    TranslationLocales.english: '  Tuesday',
    TranslationLocales.german: ' Dienstag',
  },
  'Wednesday': {
    TranslationLocales.english: 'Wednesday',
    TranslationLocales.german: ' Mittwoch',
  },
  'Thursday ': {
    TranslationLocales.english: 'Thursday ',
    TranslationLocales.german: 'Donnerstag',
  },
  'Friday   ': {
    TranslationLocales.english: 'Friday   ',
    TranslationLocales.german: 'Freitag  ',
  },
  'Saturday ': {
    TranslationLocales.english: 'Saturday ',
    TranslationLocales.german: 'Samstag  ',
  },
  '  Sunday ': {
    TranslationLocales.english: '  Sunday ',
    TranslationLocales.german: ' Sonntag ',
  },
  'Settings': {
    TranslationLocales.english: 'Settings',
    TranslationLocales.german: 'Einstellungen',
  },
  'start work': {
    TranslationLocales.english: 'start work',
    TranslationLocales.german: 'Arbeit starten',
  },
  'end work': {
    TranslationLocales.english: 'end work',
    TranslationLocales.german: 'Arbeit beenden',
  },
  'change language': {
    TranslationLocales.english: 'change language',
    TranslationLocales.german: 'Sprache ändern',
  },
  'change password': {
    TranslationLocales.english: 'change password',
    TranslationLocales.german: 'Passwort ändern',
  },
  'submit': {
    TranslationLocales.english: 'submit',
    TranslationLocales.german: 'speichern',
  },
  'current password': {
    TranslationLocales.english: 'current password',
    TranslationLocales.german: 'aktuelles Passwort',
  },
  'new password': {
    TranslationLocales.english: 'new password',
    TranslationLocales.german: 'neues Passwort',
  },
  'confirm new password': {
    TranslationLocales.english: 'confirm new password',
    TranslationLocales.german: 'aktuelles Passwort bestätigen',
  },
  'no work data available': {
    TranslationLocales.english: 'no work data available',
    TranslationLocales.german: 'keine Daten zur Arbeitszeit verfügbar',
  },
  'log out?': {
    TranslationLocales.english: 'log out?',
    TranslationLocales.german: 'Ausloggen?',
  },
  'Do you really want to log out?\nYou\'ll have to log in again to use the '
      'services': {
    TranslationLocales.english:
        'Do you really want to log out?\nYou\'ll have to log in again to use the '
        'services',
    TranslationLocales.german:
        'Möchtest du dich wirklich ausloggen?\nDu wirst'
        ' dich erneut einloggen müssen um unsere Dienste zu nutzen',
  },
};

HashMap<String, Map<Locale, String>> get translations {
  HashMap<String, Map<Locale, String>> local = HashMap.from(_translations);
  local.addAll(HashMap.from(StandardTranslations.all));
  return local;
}
