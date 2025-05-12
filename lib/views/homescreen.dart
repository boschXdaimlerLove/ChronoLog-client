import 'package:chrono_log/views/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:string_translate/string_translate.dart'
    show Translate, Translation, TranslationLocales;

import 'calendar/calendar_list_view.dart';

final class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

final class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: Icon(Icons.outdoor_grill, color: Colors.black),
            ),
            Text("BBQ Working Time Management".tr()),
          ],
        ),
        leading: TextButton(
          onPressed: () {
            // TODO: implement logout method
          },
          child: Row(children: [Icon(Icons.arrow_back), Text("Logout".tr())]),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextButton(
              onPressed:
                  () => setState(
                    () =>
                        Translation.changeLanguage(TranslationLocales.english),
                  ),
              child: Text("🇬🇧"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextButton(
              onPressed:
                  () => setState(
                    () => Translation.changeLanguage(TranslationLocales.german),
                  ),
              child: Text("🇩🇪"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: IconButton(
              onPressed:
                  () => Navigator.of(
                    context,
                  ).push(MaterialPageRoute(builder: (_) => SettingsScreen())),
              icon: Icon(Icons.settings, color: Colors.black),
            ),
          ),
        ],
        backgroundColor: Colors.grey.shade100,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
        child: Row(
          children: [
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
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
            Flexible(flex: 8, child: CalendarListView()),
          ],
        ),
      ),
    );
  }
}
