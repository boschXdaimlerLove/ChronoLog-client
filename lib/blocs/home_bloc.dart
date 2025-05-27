import 'dart:async' show StreamController;

import 'package:bloc_implementation/bloc_implementation.dart' show Bloc;
import 'package:chrono_log/api/server_communication.dart';
import 'package:chrono_log/models/events/event.dart';

final class HomeBloc extends Bloc {
  String _username = '';

  String _password = '';

  String get username => _username;

  String get password => _password;

  bool _stampedIn = false;

  bool get stampedIn => _stampedIn;

  final StreamController<Event> _eventStream = StreamController<Event>();

  StreamController<Event> get eventStream => _eventStream;

  void login(final String username, final String password) {
    _username = username;
    _password = password;
  }

  void stamp() {
    if (_stampedIn) {
      ServerCommunication.endWork(username, password);
      _stampedIn = false;
    } else {
      ServerCommunication.startWork(username, password);
      _stampedIn = true;
    }
  }

  @override
  void dispose() {
    _username = '';
    _password = '';
    _stampedIn = false;
    _eventStream.close();
  }
}