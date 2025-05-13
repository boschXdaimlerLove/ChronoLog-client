import 'package:bloc_implementation/bloc_implementation.dart';
import 'package:chrono_log/blocs/home_bloc.dart';
import 'package:chrono_log/translations.dart';
import 'package:chrono_log/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:modern_themes/modern_themes.dart' show Themes;
import 'package:string_translate/string_translate.dart'
    hide StandardTranslations;

void main() {
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
    Translation.init(
      supportedLocales: {TranslationLocales.english, TranslationLocales.german},
      defaultLocale: TranslationLocales.english,
      translations: translations,
    );
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

      // General
      scrollBehavior: const MaterialScrollBehavior(),
      title: "BBQ Worktime Management",

      // Screens
      home: BlocParent(bloc: HomeBloc(), child: LoginView()),
    );
  }
}