import 'package:bloc_implementation/bloc_implementation.dart';
import 'package:chrono_log/blocs/home_bloc.dart';
import 'package:chrono_log/storage/storage.dart';
import 'package:chrono_log/themes.dart';
import 'package:chrono_log/translations.dart';
import 'package:chrono_log/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:modern_themes/modern_themes.dart' show Themes;
import 'package:string_translate/string_translate.dart'
    hide StandardTranslations;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Storage.init();
  runApp(const ChronoLogApp());
}

final class ChronoLogApp extends StatefulWidget {
  const ChronoLogApp({super.key});

  @override
  State<ChronoLogApp> createState() => _ChronoLogAppState();
}

final class _ChronoLogAppState extends State<ChronoLogApp> {
  @override
  void initState() {
    /* TRANSLATION PACKAGE */
    Translation.init(
      supportedLocales: {TranslationLocales.english, TranslationLocales.german},
      defaultLocale: TranslationLocales.english,
      translations: translations,
    );
    /* LOCAL NOTIFICATION PACKAGE */
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
          notificationCategories: [],
        );

    final InitializationSettings initializationSettings =
        InitializationSettings(
          macOS: initializationSettingsDarwin,
          // TODO: init windows settings
          //windows: ,
        );

    /* THEME PACKAGE */
    Themes.lightTheme = chronoLogLightTheme;
    Themes.darkTheme = chronoLogDarkTheme;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      home: PlatformMenuBar(
        menus: [
          PlatformMenu(
            label: 'Default',
            menus: [
              PlatformMenuItemGroup(
                members: [PlatformMenuItem(label: 'Hallo')],
              ),
            ],
          ),
          PlatformMenu(
            label: 'Settings',
            menus: [
              PlatformMenuItemGroup(
                members: [
                  PlatformMenu(
                    label: 'Change language',
                    menus: [
                      PlatformMenuItem(
                        label: 'English',
                        onSelected: () {
                          setState(() {
                            Translation.changeLanguage(
                              TranslationLocales.english,
                            );
                          });
                        },
                      ),
                      PlatformMenuItem(
                        label: 'German',
                        onSelected: () {
                          setState(() {
                            Translation.changeLanguage(
                              TranslationLocales.german,
                            );
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
        child: BlocParent(bloc: HomeBloc(), child: LoginView()),
      ),

      // TODO: (optional): keyboard shortcuts
    );
  }
}
