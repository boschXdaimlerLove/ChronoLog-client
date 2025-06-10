import 'package:bloc_implementation/bloc_implementation.dart';
import 'package:chrono_log/blocs/calendar_day_bloc.dart';
import 'package:chrono_log/models/time_frame.dart';
import 'package:chrono_log/storage/storage.dart';
import 'package:chrono_log/views/dialogs/add_times_screen.dart';
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
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 400, maxWidth: 600),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(child: _workTimeList),
      ),
    );
  }

  Widget get _workTimeList {
    final List<Widget> children = [];
    if (_frames!.isEmpty) {
      children.add(
        Expanded(
          flex: 10,
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Center(child: Text('No work data available'.tr())),
          ),
        ),
      );
    } else {
      children.add(
        Expanded(
          flex: 5,
          child: ListView.builder(
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
                                  '${'Start'.tr()}: ${DateFormat('hh:mm').format(frame.start)}',
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
                                  '${'End: '.tr()} ${frame.end != null ? DateFormat('hh:mm').format(frame.end!) : 'Unfinished'}',
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
                                  '${'Working time'.tr()}: ${frame.getWorkingTimeRepresentation()}',
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
          ),
        ),
      );
    }
    children.add(
      Expanded(
        flex: 1,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                showDialog(
                  context: context,
                  builder: (_) {
                    return Dialog(
                      child: BlocParent(bloc: _bloc!, child: AddTimesScreen()),
                    );
                  },
                );
              },
              child: Text('Add times'.tr()),
            ),
          ],
        ),
      ),
    );
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
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
    } else if (frame.getWorkingTime().inHours > 10) {
      hint = 'problematic'.tr();
      icon = Icons.warning;
      color = Colors.red;
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