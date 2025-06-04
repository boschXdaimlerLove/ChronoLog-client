import 'package:bloc_implementation/bloc_implementation.dart';
import 'package:chrono_log/blocs/calendar_day_bloc.dart';
import 'package:chrono_log/storage/storage.dart';
import 'package:chrono_log/views/calendar/calendar_day_view.dart';
import 'package:flutter/material.dart';

final class CalendarListTile extends StatefulWidget {
  const CalendarListTile(this.date, {super.key, this.previousMonth = false});

  final bool previousMonth;

  final DateTime date;

  @override
  State<CalendarListTile> createState() => _CalendarListTileState();
}

class _CalendarListTileState extends State<CalendarListTile> {
  bool _hasDates = false;

  @override
  Widget build(BuildContext context) {
    _hasDates = Storage.getFramesForDay(widget.date).isNotEmpty;
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(_backgroundColor),
        side: WidgetStatePropertyAll(
          BorderSide(
            style: BorderStyle.solid,
            color:
                widget.previousMonth
                    ? Colors.teal.shade100
                    : Colors.teal.shade400,
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
                bloc: CalendarDayBloc(widget.date),
                child: CalendarDayView(),
              ),
            );
          },
        );
      },
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(flex: 2),
            Text('${widget.date.day}'),
            _hasDates ? Icon(Icons.circle, size: 10) : Container(),
            Spacer(flex: _hasDates ? 1 : 2),
          ],
        ),
      ),
    );
  }

  Color get _backgroundColor {
    DateTime today = DateTime.now();
    if (widget.previousMonth) {
      return Colors.teal.shade50;
    }
    if (widget.date.day == today.day &&
        widget.date.month == today.month &&
        widget.date.year == today.year) {
      return Colors.teal.shade300;
    } else {
      return Colors.teal.shade100;
    }
  }
}