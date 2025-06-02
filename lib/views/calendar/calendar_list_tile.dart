import 'package:bloc_implementation/bloc_implementation.dart';
import 'package:chrono_log/blocs/calendar_day_bloc.dart';
import 'package:chrono_log/views/calendar/calendar_day_view.dart';
import 'package:flutter/material.dart';

final class CalendarListTile extends StatelessWidget {
  const CalendarListTile(this.date, {super.key, this.previousMonth = false});

  final bool previousMonth;

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(_backgroundColor),
        side: WidgetStatePropertyAll(
          BorderSide(
            style: BorderStyle.solid,
            color: previousMonth ? Colors.teal.shade100 : Colors.teal.shade400,
          ),
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.all(Radius.zero),
          ),
        ),
      ),
      onPressed: () {
        showDialog(
          context: context,
          builder: (_) {
            return Dialog(
              child: BlocParent(
                bloc: CalendarDayBloc(date),
                child: CalendarDayView(),
              ),
            );
          },
        );
      },
      child: Center(child: Text('${date.day}')),
    );
  }

  Color get _backgroundColor {
    DateTime today = DateTime.now();
    if (previousMonth) {
      return Colors.teal.shade50;
    }
    if (date.day == today.day &&
        date.month == today.month &&
        date.year == today.year) {
      return Colors.teal.shade300;
    } else {
      return Colors.teal.shade100;
    }
  }
}