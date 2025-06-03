import 'package:bloc_implementation/bloc_implementation.dart' show Bloc;
import 'package:chrono_log/api/server_communication.dart';
import 'package:chrono_log/blocs/event_bloc.dart';
import 'package:chrono_log/models/events/change_password_event.dart';

final class SettingsBloc extends Bloc {
  SettingsBloc(this._username);

  final String _username;

  String oldPassword = '';

  String newPassword = '';

  String newPasswordConfirm = '';

  void submit() {
    if (newPassword == newPasswordConfirm && newPassword.isNotEmpty) {
      ServerCommunication.changePassword(_username, oldPassword, newPassword);
      EventBloc.eventStream.sink.add(ChangePasswordEvent(newPassword));
    } else {
      // TODO: throw error
    }
  }

  @override
  void dispose() {
    oldPassword = '';
    newPassword = '';
    newPasswordConfirm = '';
  }
}