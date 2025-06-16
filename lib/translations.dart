import 'dart:collection' show HashMap;
import 'dart:ui' show Locale;

import 'package:string_translate/string_translate.dart'
    show TranslationLocales, StandardTranslations;

Map<String, Map<Locale, String>> _translations = {
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

  /* MONTHS */
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

  /* DAYS */
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

  /* SETTINGS */
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
  'Change language': {
    TranslationLocales.english: 'Change language',
    TranslationLocales.german: 'Sprache ändern',
  },
  'change password': {
    TranslationLocales.english: 'change password',
    TranslationLocales.german: 'Passwort ändern',
  },
  'Change password': {
    TranslationLocales.english: 'Change password',
    TranslationLocales.german: 'Passwort ändern',
  },
  'submit': {
    TranslationLocales.english: 'submit',
    TranslationLocales.german: 'speichern',
  },
  'Submit': {
    TranslationLocales.english: 'Submit',
    TranslationLocales.german: 'Speichern',
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
  'Back': {
    TranslationLocales.english: 'Back',
    TranslationLocales.german: 'Zurück',
  },
  'read': {
    TranslationLocales.english: 'read',
    TranslationLocales.german: 'gelesen',
  },
  'delete': {
    TranslationLocales.english: 'delete',
    TranslationLocales.german: 'löschen',
  },
  'About': {
    TranslationLocales.english: 'About',
    TranslationLocales.german: 'Über',
  },
  'User': {
    TranslationLocales.english: 'User',
    TranslationLocales.german: 'Nutzer',
  },
  'Default': {
    TranslationLocales.english: 'Default',
    TranslationLocales.german: 'Standard',
  },

  /* NOTIFICATIONS */
  'No new messages': {
    TranslationLocales.english: 'No new messages',
    TranslationLocales.german: 'Keine neuen Nachrichten',
  },
  'Working too long': {
    TranslationLocales.english: 'Working too long',
    TranslationLocales.german: 'Zu langes arbeiten',
  },
  'You\'ve worked too long for today. End work and go home': {
    TranslationLocales.english:
        'You\'ve worked too long for today. End work and go home',
    TranslationLocales.german:
        'Du hast heute zu lange gearbeitet. Beende die Arbeit ung gehe heim',
  },
  'Break needed': {
    TranslationLocales.english: 'Break needed',
    TranslationLocales.german: 'Pause benötigt',
  },
  'You\'ve worked to long without a break, consider taking a break': {
    TranslationLocales.english:
        'You\'ve worked to long without a break, consider taking a break',
    TranslationLocales.german:
        'Du hast zu lange ohne Pause gearbeitet, nimm eine Pause',
  },
  'Holiday': {
    TranslationLocales.english: 'Holiday',
    TranslationLocales.german: 'Ferien',
  },
  'Today\'s a holiday, you shouldn\'t work today': {
    TranslationLocales.english: 'Today\'s a holiday, you shouldn\'t work today',
    TranslationLocales.german:
        'Heute ist ein Feiertag, du solltest heute nicht arbeiten',
  },
  'Not logged in': {
    TranslationLocales.english: 'Not logged in',
    TranslationLocales.german: 'Nicht eingelogged',
  },
  'You\'re not logged in, please log in before trying to start work': {
    TranslationLocales.english:
        'You\'re not logged in, please log in before trying to start work',
    TranslationLocales.german:
        'Du bist nicht eingelogged, bitte log dich ein, bevor du die Arbeit startest',
  },
  'Today': {
    TranslationLocales.english: 'Today',
    TranslationLocales.german: 'Heute',
  },
  'Add times': {
    TranslationLocales.english: 'Add times',
    TranslationLocales.german: 'Zeiten hinzufügen',
  },
  'Working time': {
    TranslationLocales.english: 'Working time',
    TranslationLocales.german: 'Arbeitszeit',
  },
  'Start': {
    TranslationLocales.english: 'Start',
    TranslationLocales.german: 'Start',
  },
  'End: ': {
    TranslationLocales.english: 'End: ',
    TranslationLocales.german: 'Ende:',
  },
  'Unfinished': {
    TranslationLocales.english: 'Unfinished',
    TranslationLocales.german: 'Unbeendet',
  },
  'Add new time': {
    TranslationLocales.english: 'Add new time',
    TranslationLocales.german: 'Neue Zeit hinzufügen',
  },
  'Choose date': {
    TranslationLocales.english: 'Choose date',
    TranslationLocales.german: 'Datum wählen',
  },
  'Start time': {
    TranslationLocales.english: 'Start time',
    TranslationLocales.german: 'Startzeit',
  },
  'End time': {
    TranslationLocales.english: 'End time',
    TranslationLocales.german: 'Endzeit',
  },
  'Select time': {
    TranslationLocales.english: 'Select time',
    TranslationLocales.german: 'Zeit wählen',
  },
  'The new password must contain the following:': {
    TranslationLocales.english: 'The new password must contain the following:',
    TranslationLocales.german: 'Das neue Passwort muss folgendes enthalten:',
  },
  '- 1 capital letter': {
    TranslationLocales.english: '- 1 capital letter',
    TranslationLocales.german: '- 1 Großbuchstaben',
  },
  '- 1 lowercase letter': {
    TranslationLocales.english: '- 1 lowercase letter',
    TranslationLocales.german: '- 1 Kleinbuchstaben',
  },
  '- 1 number': {
    TranslationLocales.english: '- 1 number',
    TranslationLocales.german: '- 1 Zahl',
  },
  '- 1 special character': {
    TranslationLocales.english: '- 1 special character',
    TranslationLocales.german: '- 1 Sonderzeichen',
  },
  'Show change Password Notification': {
    TranslationLocales.english: 'Show change Password Notification',
    TranslationLocales.german: 'Zeige Passwortänderungsbenachrichtigung',
  },
  'Password change required': {
    TranslationLocales.english: 'Password change required',
    TranslationLocales.german: 'Passwortänderung erforderlich',
  },
  'You\'re required to change your password in the next month': {
    TranslationLocales.english:
        'You\'re required to change your password in the next month',
    TranslationLocales.german:
        'Du musst dein Passwort innerhalb des nächsten Monats ändern',
  },
  'Show notification': {
    TranslationLocales.english: 'Show notification',
    TranslationLocales.german: 'Benachrichtigung anzeigen',
  },
  'Debug Notification': {
    TranslationLocales.english: 'Debug Notification',
    TranslationLocales.german: 'Testbenachrichtigung anzeigen',
  },
  'This is a debug notification shown to test the plugin': {
    TranslationLocales.english:
        'This is a debug notification shown to test the plugin',
    TranslationLocales.german:
        'Das ist eine Testbenachrichtigung um das Plugin zu testen',
  },
  'Change theme': {
    TranslationLocales.english: 'Change theme',
    TranslationLocales.german: 'Thema ändern',
  },
  'light': {
    TranslationLocales.english: 'light',
    TranslationLocales.german: 'Hell',
  },
  'dark': {
    TranslationLocales.english: 'dark',
    TranslationLocales.german: 'Dunkel',
  },
  'system': {
    TranslationLocales.english: 'system',
    TranslationLocales.german: 'System',
  },
  'Confirm new password': {
    TranslationLocales.english: 'Confirm new password',
    TranslationLocales.german: 'Neues Passwort bestätigen',
  },
  'This software is only developed for a project for the bachelor of science on the DHBW Stuttgart.\nIt is not applicable for commercial use.': {
    TranslationLocales.english:
        'This software is only developed for a project for the bachelor of science on the DHBW Stuttgart.\nIt is not applicable for commercial use.',
    TranslationLocales.german:
        'Diese Software wurde ausschließlich für ein Projekt des Bachelors an der DHBW Stuttgart entwickelt. Es ist nicht für den komerziellen Nutzen freigegeben',
  },
  'More information': {
    TranslationLocales.english: 'More information',
    TranslationLocales.german: 'Mehr Informationen',
  },
  'all good': {
    TranslationLocales.english: 'all good',
    TranslationLocales.german: 'alles gut',
  },
  'problematic': {
    TranslationLocales.english: 'promlematic',
    TranslationLocales.german: 'problematisch',
  },
  'critical': {
    TranslationLocales.english: 'critical',
    TranslationLocales.german: 'kritisch',
  },
  'No hint': {
    TranslationLocales.english: 'No hint',
    TranslationLocales.german: 'Kein Hinweis',
  },
};

HashMap<String, Map<Locale, String>> get translations {
  HashMap<String, Map<Locale, String>> local = HashMap.from(_translations);
  local.addAll(HashMap.from(StandardTranslations.all));
  return local;
}