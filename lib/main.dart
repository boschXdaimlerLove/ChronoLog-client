import 'package:chrono_log/translations.dart';
import 'package:chrono_log/views/calendar/calendar_list_view.dart';
import 'package:flutter/material.dart';
import 'package:string_translate/string_translate.dart';

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

      // General
      scrollBehavior: const MaterialScrollBehavior(),

      home: Scaffold(
        appBar: AppBar(title: Text("BBQ Working Time Management".tr())),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
          child: Row(
            children: [
              Flexible(
                fit: FlexFit.tight,
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [Text("No unread messages".tr())],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: VerticalDivider(thickness: 1.5),
              ),
              Flexible(flex: 12, child: CalendarListView()),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: VerticalDivider(thickness: 1.5),
              ),
              Flexible(
                fit: FlexFit.tight,
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      height: 100,
                      width: 200,
                      child: TextButton(
                        onPressed: () {
                          setState(
                            () => Translation.changeLanguage(
                              TranslationLocales.english,
                            ),
                          );
                        },
                        child: Text("🇬🇧", style: TextStyle(fontSize: 48)),
                      ),
                    ),
                    SizedBox(
                      height: 100,
                      width: 200,
                      child: TextButton(
                        onPressed: () {
                          setState(
                            () => Translation.changeLanguage(
                              TranslationLocales.german,
                            ),
                          );
                        },
                        child: Text("🇩🇪", style: TextStyle(fontSize: 48)),
                      ),
                    ),
                    SizedBox(
                      height: 100,
                      width: 200,
                      child: TextButton(
                        onPressed: () {},
                        child: Center(child: Icon(Icons.settings, size: 48)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
