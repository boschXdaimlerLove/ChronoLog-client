import 'package:bloc_implementation/bloc_implementation.dart';
import 'package:chrono_log/blocs/calendar_day_bloc.dart';
import 'package:chrono_log/blocs/home_bloc.dart';
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

  HomeBloc? _bloc;

  @override
  Widget build(BuildContext context) {
    _bloc ??= BlocParent.of(context);
    _hasDates = Storage.getFramesForDay(widget.date).isNotEmpty;
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(_backgroundColor),
        side: WidgetStatePropertyAll(
          BorderSide(
            style: BorderStyle.solid,
            color:
                widget.previousMonth
                    ? Colors.grey.shade50
                    : Colors.grey.shade300,
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
                bloc: CalendarDayBloc(
                  widget.date,
                  username: _bloc!.username,
                  password: _bloc!.password,
                ),
                child: CalendarDayView(),
              ),
            );
          },
        ).then((_) {
          setState(() {
            _hasDates = Storage.getFramesForDay(widget.date).isNotEmpty;
          });
        });
      },
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(flex: 2),
            Text(
              '${widget.date.day}',
              style: TextStyle(
                color:
                    (widget.date.day == DateTime.now().day &&
                            widget.date.month == DateTime.now().month &&
                            widget.date.year == DateTime.now().year)
                        ? Colors.white
                        : (widget.previousMonth)
                        ? Colors.grey.shade400
                        : Colors.grey.shade900,
              ),
            ),
            _hasDates
                ? Icon(
                  Icons.circle,
                  size: 10,
                  color:
                      (widget.date.day == DateTime.now().day &&
                              widget.date.month == DateTime.now().month &&
                              widget.date.year == DateTime.now().year)
                          ? Colors.white
                          : Colors.grey.shade900,
                )
                : Container(),
            Spacer(flex: _hasDates ? 1 : 2),
          ],
        ),
      ),
    );
  }

  Color get _backgroundColor {
    DateTime today = DateTime.now();
    if (widget.previousMonth) {
      return Colors.grey.shade50;
    }
    if (widget.date.day == today.day &&
        widget.date.month == today.month &&
        widget.date.year == today.year) {
      return Colors.blue.shade500;
    } else {
      return Colors.grey.shade100;
    }
  }
}