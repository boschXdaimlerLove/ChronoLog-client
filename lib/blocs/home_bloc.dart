import 'package:bloc_implementation/bloc_implementation.dart' show Bloc;

final class HomeBloc extends Bloc {
  String _username = "";

  String _password = "";

  void login(final String username, final String password) {
    _username = username;
    _password = password;
  }

  String get username => _username;

  String get password => _password;

  @override
  void dispose() {
    _username = "";
    _password = "";
  }
}