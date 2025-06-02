import 'package:bloc_implementation/bloc_implementation.dart' show Bloc;

final class CalendarListBloc extends Bloc {
  int _currentMonth = DateTime.now().month;

  int _currentYear = DateTime.now().year;

  int get currentMonth => _currentMonth;

  int get currentYear => _currentYear;

  void changeMonth({bool forward = true}) {
    if (forward) {
      if (_currentMonth == 12) {
        _currentMonth = 1;
        _currentYear++;
      } else {
        _currentMonth++;
      }
    } else {
      if (_currentMonth == 1) {
        _currentMonth = 12;
        _currentYear--;
      } else {
        _currentMonth--;
      }
    }
  }

  int get previousMonth {
    return _currentMonth == 1 ? 12 : _currentMonth - 1;
  }

  int get previousYearIfNecessary {
    return _currentMonth == 1 ? _currentYear - 1 : _currentYear;
  }

  @override
  void dispose() {
    _currentYear = DateTime.now().year;
    _currentMonth = DateTime.now().month;
  }
}