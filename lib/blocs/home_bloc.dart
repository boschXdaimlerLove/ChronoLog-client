import 'dart:async' show StreamSubscription;

import 'package:bloc_implementation/bloc_implementation.dart' show Bloc;
import 'package:chrono_log/api/server_communication.dart';
import 'package:chrono_log/blocs/event_bloc.dart';
import 'package:chrono_log/models/events/change_password_event.dart';
import 'package:chrono_log/models/events/event.dart';
import 'package:chrono_log/models/events/login_event.dart';
import 'package:chrono_log/models/events/notification_triggered_event.dart';
import 'package:chrono_log/models/notification.dart';
import 'package:chrono_log/models/time_frame.dart';
import 'package:chrono_log/storage/storage.dart';

final class HomeBloc extends Bloc {
  String _username = '';

  String _password = '';

  String get username => _username;

  String get password => _password;

  bool _stampedIn = false;

  bool get stampedIn => _stampedIn;

  bool _loggedIn = false;

  bool get loggedIn => _loggedIn;

  StreamSubscription<Event>? _streamSubscription;

  final Function() _reloadCallback;

  List<Notification> _notifications = [];

  List<Notification> get notifications => _notifications;

  HomeBloc(this._reloadCallback) {
    _streamSubscription = EventBloc.eventStream.stream.listen(
      (event) => _handleEvents(event),
    );
    _notifications = List.from(Storage.notifications);
    _notifications.sort((a, b) => a.alreadyRead ? 1 : -1);
  }

  void _handleEvents(Event event) {
    if (event is ChangePasswordEvent) {
      _password = event.password;
    } else if (event is NotificationTriggeredEvent) {
      _notifications.add(event.notification);
      Storage.storeNewNotification(event.notification);
      _reloadCallback();
    }
  }

  void login(final String username, final String password) {
    _username = username;
    _password = password;
    ServerCommunication.initStatusPolling(username, password);
    EventBloc.eventStream.sink.add(LoginEvent(username));
    _loggedIn = true;
  }

  void deleteNotification(Notification notification) {
    Storage.deleteNotification(notification);
    _notifications.remove(notification);
  }

  Future<void> stamp() async {
    if (_stampedIn) {
      _stampedIn = false;
      DateTime endTime = await ServerCommunication.endWork(username, password);
      TimeFrame unfinishedFrame = Storage.getLastUnfinishedTimeFrame();
      unfinishedFrame.end = endTime;
      Storage.updateUnfinishedTimeFrame(unfinishedFrame);
    } else {
      _stampedIn = true;
      DateTime unfinishedStartTime = await ServerCommunication.startWork(
        username,
        password,
      );
      Storage.storeNewTime(TimeFrame.unfinished(unfinishedStartTime));
    }
  }

  @override
  void dispose() {
    _username = '';
    _password = '';
    _stampedIn = false;
    _loggedIn = false;
    _streamSubscription?.cancel();
  }
}