import 'dart:io' show Platform;

import 'package:bloc_implementation/bloc_implementation.dart' show BlocParent;
import 'package:chrono_log/blocs/event_bloc.dart';
import 'package:chrono_log/blocs/home_bloc.dart';
import 'package:chrono_log/control/escape_intent.dart';
import 'package:chrono_log/control/quit_intent.dart';
import 'package:chrono_log/control/tab_select_intent.dart';
import 'package:chrono_log/models/events/event.dart';
import 'package:chrono_log/models/events/login_event.dart';
import 'package:chrono_log/models/events/logout_event.dart';
import 'package:chrono_log/storage/storage.dart';
import 'package:chrono_log/themes.dart';
import 'package:chrono_log/translations.dart';
import 'package:chrono_log/views/homescreen.dart';
import 'package:chrono_log/views/login_view.dart';
import 'package:chrono_log/views/macos_menu_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show LogicalKeyboardKey;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:modern_themes/modern_themes.dart' show Themes;
import 'package:string_translate/string_translate.dart'
    hide StandardTranslations;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Storage.init();

  /* LOCAL NOTIFICATION PACKAGE */
  final DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        notificationCategories: [DarwinNotificationCategory('plainCategory')],
      );
  final LinuxInitializationSettings initializationSettingsLinux =
      LinuxInitializationSettings(
        defaultActionName: 'Open notification',
        defaultIcon: AssetsLinuxIcon('icons/app_icon.png'),
      );
  final WindowsInitializationSettings windowsInitializationSettings =
      WindowsInitializationSettings(
        appName: 'ChronoLog',
        appUserModelId: 'edu.jules.bachelor.chronolog',
        guid: UniqueKey().toString(),
        iconPath: 'assets/app_icon.png',
      );
  final InitializationSettings initializationSettings = InitializationSettings(
    macOS: initializationSettingsDarwin,
    windows: windowsInitializationSettings,
    linux: initializationSettingsLinux,
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  runApp(const ChronoLogApp());
}

bool get isWindowsOrLinux {
  return Platform.isWindows || Platform.isLinux;
}

bool get isMacOS {
  return Platform.isMacOS;
}

bool get isDesktop {
  return isMacOS || isWindowsOrLinux;
}

bool get isMobile {
  return Platform.isAndroid || Platform.isFuchsia || Platform.isIOS;
}

final class ChronoLogApp extends StatefulWidget {
  const ChronoLogApp({super.key});

  @override
  State<ChronoLogApp> createState() => _ChronoLogAppState();
}

final class _ChronoLogAppState extends State<ChronoLogApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  Widget? _child;

  HomeBloc? _bloc;

  void _handleEvents(Event event) {
    if (event is LogoutEvent) {
      if (_bloc!.stampedIn) {
        _bloc!.stamp();
      }
      setState(() {
        _child = BlocParent(bloc: _bloc!, child: LoginView());
      });
    } else if (event is LoginEvent) {
      setState(() {
        _child = BlocParent(bloc: _bloc!, child: Homescreen());
      });
    }
  }

  @override
  void initState() {
    _bloc = HomeBloc(() {
      setState(() {});
    });
    _child = BlocParent(bloc: _bloc!, child: LoginView());
    EventBloc.eventStream.stream.listen((event) => _handleEvents(event));
    /* TRANSLATION PACKAGE */
    Translation.init(
      supportedLocales: {TranslationLocales.english, TranslationLocales.german},
      defaultLocale: TranslationLocales.english,
      translations: translations,
    );
    /* THEME PACKAGE */
    Themes.lightTheme = chronoLogLightTheme;
    Themes.darkTheme = chronoLogDarkTheme;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //restorationScopeId: 'ChronoLog',
      navigatorKey: navigatorKey,
      // Locales
      localizationsDelegates: TranslationDelegates.localizationDelegates,
      locale: Translation.activeLocale,
      supportedLocales: Translation.supportedLocales,

      // Debug
      debugShowMaterialGrid: false,
      showSemanticsDebugger: false,
      showPerformanceOverlay: false,
      checkerboardRasterCacheImages: false,
      checkerboardOffscreenLayers: false,
      debugShowCheckedModeBanner: true,

      // Themes
      themeMode: Themes.themeMode,
      theme: Themes.lightTheme,
      darkTheme: Themes.darkTheme,
      highContrastTheme: Themes.highContrastLightTheme,
      highContrastDarkTheme: Themes.highContrastDarkTheme,

      // General
      scrollBehavior: const MaterialScrollBehavior(),
      title: 'BBQ Worktime Management',

      // Screens
      home: MacosMenuWrapper(
        reloadCallback: () => setState(() {}),
        navigatorKey: navigatorKey,
        child: _child!,
      ),
      shortcuts: {
        SingleActivator(LogicalKeyboardKey.keyQ, meta: true): QuitIntent(),
        SingleActivator(LogicalKeyboardKey.escape): EscapeIntent(navigatorKey),
      },
      actions: {
        QuitIntent: QuitAction(),
        EscapeIntent: EscapeAction(),
        TabSelectIntent: TabSelectAction(),
      },
    );
  }
}