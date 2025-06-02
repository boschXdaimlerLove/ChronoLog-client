import 'package:bloc_implementation/bloc_implementation.dart' show Bloc;
import 'package:chrono_log/api/server_communication.dart';
import 'package:chrono_log/blocs/event_bloc.dart';
import 'package:chrono_log/models/events/login_event.dart';

final class HomeBloc extends Bloc {
  String _username = '';

  String _password = '';

  String get username => _username;

  String get password => _password;

  bool _stampedIn = false;

  bool get stampedIn => _stampedIn;

  bool _loggedIn = false;

  bool get loggedIn => _loggedIn;

  void login(final String username, final String password) {
    _username = username;
    _password = password;
    ServerCommunication.initStatusPolling(username, password);
    EventBloc.eventStream.sink.add(const LoginEvent());
    _loggedIn = true;
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
    _loggedIn = false;
  }
}