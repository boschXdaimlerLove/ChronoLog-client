import 'package:bloc_implementation/bloc_implementation.dart';
import 'package:chrono_log/blocs/calendar_day_bloc.dart';
import 'package:chrono_log/models/time_frame.dart';
import 'package:chrono_log/storage/storage.dart';
import 'package:chrono_log/views/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:string_translate/string_translate.dart' show Translate;

final class CalendarDayView extends StatefulWidget {
  const CalendarDayView({super.key});

  @override
  State<CalendarDayView> createState() => _CalendarDayViewState();
}

final class _CalendarDayViewState extends State<CalendarDayView> {
  CalendarDayBloc? _bloc;

  List<TimeFrame>? _frames;

  @override
  Widget build(BuildContext context) {
    _bloc ??= BlocParent.of(context);
    _frames ??= Storage.getFramesForDay(_bloc!.day);
    return Scaffold(
      body: Column(
        children: [
          TopBar(
            navigateBack: () => Navigator.of(context).pop(),
            refreshCallback: () => setState(() {}),
          ),
          Expanded(child: _workTimeList),
        ],
      ),
    );
  }

  Widget get _workTimeList {
    if (_frames!.isEmpty) {
      return Center(child: Text('No work data available'.tr()));
    } else {
      return ListView.builder(
        itemCount: _frames!.length,
        itemBuilder: (_, counter) {
          final TimeFrame frame = _frames![counter];
          return Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: 8,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  spacing: 200,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 12,
                      children: [
                        DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              'Start: ${DateFormat('hh:mm').format(frame.start)}',
                            ),
                          ),
                        ),
                        DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              'End:   ${DateFormat('hh:mm').format(frame.end)}',
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 12,
                      children: [
                        DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              'Working time: ${frame.getWorkingTimeRepresentation()}',
                            ),
                          ),
                        ),
                        _getWorkingTimeHint(frame),
                      ],
                    ),
                  ],
                ),
                Divider(),
              ],
            ),
          );
        },
      );
    }
  }

  DecoratedBox _getWorkingTimeHint(final TimeFrame frame) {
    final String hint;
    final IconData icon;
    final Color color;
    if (frame.getWorkingTime().inHours <= 8) {
      hint = 'all good'.tr();
      icon = Icons.check;
      color = Colors.green;
    } else if (frame.getWorkingTime().inHours <= 10) {
      hint = 'critical'.tr();
      icon = Icons.warning;
      color = Colors.orange;
    } else {
      hint = 'No hint'.tr();
      icon = Icons.hourglass_empty;
      color = Colors.grey.shade500;
    }
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(icon),
            ),
            Text(hint),
          ],
        ),
      ),
    );
  }
}
