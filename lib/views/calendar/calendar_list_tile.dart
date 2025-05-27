import 'package:bloc_implementation/bloc_implementation.dart' show BlocParent;
import 'package:chrono_log/blocs/calendar_day_bloc.dart';
import 'package:flutter/material.dart'
    show
        BuildContext,
        Center,
        Color,
        Colors,
        ElevatedButton,
        StatelessWidget,
        Text,
        Navigator,
        MaterialPageRoute,
        Widget,
        ButtonStyle,
        WidgetStateProperty,
        BorderStyle,
        BorderSide,
        WidgetStatePropertyAll;

import 'calendar_day_view.dart';

final class CalendarListTile extends StatelessWidget {
  const CalendarListTile(this.date, {super.key});

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(_backgroundColor),
        side: WidgetStatePropertyAll(
          BorderSide(style: BorderStyle.solid, color: Colors.orange.shade200),
        ),
      ),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder:
                (_) => BlocParent(
                  bloc: CalendarDayBloc(date),
                  child: CalendarDayView(),
                ),
          ),
        );
      },
      child: Center(child: Text('${date.day}')),
    );
  }

  Color get _backgroundColor {
    DateTime today = DateTime.now();
    if (date.day == today.day &&
        date.month == today.month &&
        date.year == today.year) {
      return Colors.red.shade500;
    } else {
      return Colors.orange.shade400;
    }
  }
}