import 'package:bloc_implementation/bloc_implementation.dart' show BlocParent;
import 'package:chrono_log/blocs/calendar_list_bloc.dart';
import 'package:chrono_log/blocs/home_bloc.dart';
import 'package:chrono_log/models/events/event.dart';
import 'package:chrono_log/models/events/logout_event.dart';
import 'package:chrono_log/models/notification.dart';
import 'package:chrono_log/storage/storage.dart';
import 'package:chrono_log/views/calendar/calendar_list_view.dart';
import 'package:chrono_log/views/login_view.dart';
import 'package:chrono_log/views/top_bar.dart';
import 'package:flutter/material.dart' hide Notification;
import 'package:string_translate/string_translate.dart' show Translate;

final class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

final class _HomescreenState extends State<Homescreen> {
  HomeBloc? _bloc;

  List<Notification> _notifications = [];

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
    if (!HomeBloc.eventStream.hasListener) {
      HomeBloc.eventStream.stream.listen((event) {
        _handleEvents(event);
      });
    }
    _notifications = List.from(Storage.notifications);
    _notifications.sort((a, b) => a.alreadyRead ? 1 : -1);

    return Scaffold(body: _body);
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
                border: BoxBorder.all(
                  color:
                      notification.alreadyRead
                          ? Colors.teal.shade100
                          : Colors.teal.shade400,
                  style: BorderStyle.solid,
                ),
                color:
                    notification.alreadyRead
                        ? Colors.teal.shade50
                        : Colors.teal.shade100,
              ),
              child: ListTile(
                title: Text(notification.title),
                titleTextStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color:
                      notification.alreadyRead
                          ? Colors.black54
                          : Colors.black87,
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(notification.message),
                ),
                subtitleTextStyle: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color:
                      notification.alreadyRead
                          ? Colors.black38
                          : Colors.black54,
                ),
                isThreeLine: true,
              ),
            ),
          );
        },
      );
    }
  }

  Widget get _body {
    return Column(
      children: [
        TopBar(refreshCallback: () => setState(() {})),
        Expanded(
          flex: 10,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
            child: Row(
              children: [
                Expanded(flex: 1, child: _notificationColumn),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: VerticalDivider(thickness: 1.5),
                ),
                Expanded(
                  flex: 4,
                  child: LayoutBuilder(
                    builder: (_, constraints) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            flex: 5,
                            child: BlocParent(
                              bloc: CalendarListBloc(),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: CalendarListView(),
                              ),
                            ),
                          ),
                          Center(
                            child: Padding(
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
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
