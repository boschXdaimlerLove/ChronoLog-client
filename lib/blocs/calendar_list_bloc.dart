import 'package:bloc_implementation/bloc_implementation.dart' show Bloc;

final class CalendarListBloc extends Bloc {
  int _currentMonth = DateTime.now().month;

  int _currentYear = DateTime.now().year;

  int get currentMonth => _currentMonth;

  int get currentYear => _currentYear;

  void changeMonth({bool forward = true}) {
    if (forward) {
      _currentMonth == 12 ? _currentMonth = 1 : _currentMonth++;
    } else {
      _currentMonth == 1 ? _currentMonth = 12 : _currentMonth--;
    }
  }

  @override
  void dispose() {
    _currentYear = DateTime.now().year;
    _currentMonth = DateTime.now().month;
  }
}