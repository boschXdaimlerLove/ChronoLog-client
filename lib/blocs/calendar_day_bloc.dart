import 'package:bloc_implementation/bloc_implementation.dart' show Bloc;

final class CalendarDayBloc extends Bloc {
  CalendarDayBloc(this.day);

  final DateTime day;

  @override
  void dispose() {}
}