import 'package:chrono_log/calendar_list_view.dart';
import 'package:flutter/material.dart';
import 'package:string_translate/string_translate.dart';

void main() {
  runApp(const ChronoLogApp());
}

class ChronoLogApp extends StatefulWidget {
  const ChronoLogApp({super.key});

  @override
  State<ChronoLogApp> createState() => _ChronoLogAppState();
}

class _ChronoLogAppState extends State<ChronoLogApp> {
  @override
  void initState() {
    /*
    Translation.init(
      supportedLocales: {TranslationLocales.english, TranslationLocales.german},
      defaultLocale: TranslationLocales.english,
      translations: translations,
    );
     */
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
              Flexible(
                fit: FlexFit.tight,
                flex: 10,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [Center(child: CalendarListView())],
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          Translation.changeLanguage(
                            TranslationLocales.english,
                          );
                        });
                      },
                      child: Text("🇺🇸"),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          Translation.changeLanguage(TranslationLocales.german);
                        });
                      },
                      child: Text("🇩🇪"),
                    ),
                    TextButton(onPressed: () {}, child: Icon(Icons.settings)),
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
