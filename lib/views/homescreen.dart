import 'package:bloc_implementation/bloc_implementation.dart' show BlocParent;
import 'package:chrono_log/blocs/calendar_list_bloc.dart';
import 'package:chrono_log/blocs/home_bloc.dart';
import 'package:chrono_log/models/events/event.dart';
import 'package:chrono_log/models/events/logout_event.dart';
import 'package:chrono_log/views/calendar/calendar_list_view.dart';
import 'package:chrono_log/views/login_view.dart';
import 'package:chrono_log/views/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:string_translate/string_translate.dart'
    show Translate, Translation, TranslationLocales;

final class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

final class _HomescreenState extends State<Homescreen> {
  HomeBloc? _bloc;

  @override
  void initState() {
    if (!HomeBloc.eventStream.hasListener) {
      HomeBloc.eventStream.stream.listen((event) {
        _handleEvents(event);
      });
    }
    super.initState();
  }

  void _handleEvents(Event event) {
    if (event is LogoutEvent) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => BlocParent(bloc: _bloc!, child: LoginView()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    _bloc ??= BlocParent.of(context);

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
            Text('BBQ Working Time Management'.tr()),
          ],
        ),
        leading: IconButton(
          onPressed: () {
            HomeBloc.eventStream.sink.add(const LogoutEvent());
          },
          icon: Icon(Icons.logout),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  Colors.blueGrey.shade300,
                ),
                side: WidgetStatePropertyAll(
                  BorderSide(color: Colors.blueGrey.shade600),
                ),
              ),
              onPressed:
                  () => setState(
                    () =>
                        Translation.changeLanguage(TranslationLocales.english),
                  ),
              child: Text('🇬🇧'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  Colors.blueGrey.shade300,
                ),
                side: WidgetStatePropertyAll(
                  BorderSide(color: Colors.blueGrey.shade600),
                ),
              ),
              onPressed:
                  () => setState(
                    () => Translation.changeLanguage(TranslationLocales.german),
                  ),
              child: Text('🇩🇪'),
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
        iconTheme: IconThemeData(color: Colors.black),
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
                children: [Text('No unread messages'.tr())],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: VerticalDivider(thickness: 1.5),
            ),
            Flexible(
              flex: 8,
              child: Column(
                children: [
                  Flexible(
                    child: BlocParent(
                      bloc: CalendarListBloc(),
                      child: CalendarListView(),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: TextButton(
                          onPressed: () => setState(() => _bloc!.stamp()),
                          child: Text(
                            _bloc!.stampedIn
                                ? 'End Work'.tr()
                                : 'Start Work'.tr(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}