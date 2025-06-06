import 'package:bloc_implementation/bloc_implementation.dart' show Bloc;

final class CalendarDayBloc extends Bloc {
  CalendarDayBloc(this.day, {required this.username, required this.password});

  final String username;

  final String password;

  final DateTime day;

  @override
  void dispose() {}
}