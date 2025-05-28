import 'dart:collection' show UnmodifiableListView;

import 'package:bloc_implementation/bloc_implementation.dart' show BlocParent;
import 'package:chrono_log/blocs/calendar_list_bloc.dart';
import 'package:chrono_log/blocs/home_bloc.dart';
import 'package:chrono_log/blocs/settings_bloc.dart';
import 'package:chrono_log/models/events/event.dart';
import 'package:chrono_log/models/events/logout_event.dart';
import 'package:chrono_log/models/notification.dart';
import 'package:chrono_log/storage/storage.dart';
import 'package:chrono_log/views/calendar/calendar_list_view.dart';
import 'package:chrono_log/views/login_view.dart';
import 'package:chrono_log/views/settings_screen.dart';
import 'package:flutter/material.dart' hide Notification;
import 'package:string_translate/string_translate.dart'
    show Translate, Translation, TranslationLocales;

final class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

final class _HomescreenState extends State<Homescreen> {
  HomeBloc? _bloc;

  UnmodifiableListView<Notification> _notifications = UnmodifiableListView([]);

  void _handleEvents(Event event) {
    if (event is LogoutEvent) {
      if (_bloc!.stampedIn) {
        _bloc!.stamp();
      }
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => BlocParent(bloc: HomeBloc(), child: LoginView()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    _bloc ??= BlocParent.of(context);
    if (!_bloc!.eventStream.hasListener) {
      _bloc!.eventStream.stream.listen((event) {
        _handleEvents(event);
      });
    }
    _notifications = Storage.notifications;

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
            _bloc!.eventStream.sink.add(const LogoutEvent());
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
                  () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder:
                          (_) => BlocParent(
                            bloc: SettingsBloc(_bloc!.username),
                            child: SettingsScreen(),
                          ),
                    ),
                  ),
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
            Flexible(fit: FlexFit.tight, flex: 1, child: _notificationColumn),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
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

  Widget get _notificationColumn {
    if (_notifications.isEmpty) {
      return Text('No unread messages'.tr());
    } else {
      return ListView.builder(
        itemCount: _notifications.length,
        itemBuilder: (_, counter) {
          final Notification notification = _notifications[counter];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: BoxBorder.all(),
                color: Colors.pink.shade300,
              ),
              child: ListTile(
                title: Text(notification.title),
                titleTextStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(notification.message),
                ),
                subtitleTextStyle: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
                isThreeLine: true,
              ),
            ),
          );
        },
      );
    }
  }
}