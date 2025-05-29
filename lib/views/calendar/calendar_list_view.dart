import 'package:bloc_implementation/bloc_implementation.dart' show BlocParent;
import 'package:chrono_log/blocs/calendar_list_bloc.dart';
import 'package:chrono_log/views/calendar/calendar_list_tile.dart';
import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:string_translate/string_translate.dart' show Translate;

final class CalendarListView extends StatefulWidget {
  const CalendarListView({super.key});

  @override
  State<CalendarListView> createState() => _CalendarListViewState();
}

final class _CalendarListViewState extends State<CalendarListView> {
  CalendarListBloc? _bloc;

  int _firstMondayCounter = 0;

  @override
  Widget build(BuildContext context) {
    _bloc ??= BlocParent.of(context);
    _findFirstMonday();
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 70,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      _bloc!.changeMonth(forward: false);
                    });
                  },
                  icon: Icon(Icons.arrow_back_ios),
                ),
                Text(
                  DateFormat('MMMM yyyy')
                      .format(DateTime(_bloc!.currentYear, _bloc!.currentMonth))
                      .toString()
                      .tr(),
                  style: TextStyle(fontSize: 24),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _bloc!.changeMonth(forward: true);
                    });
                  },
                  icon: Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Spacing to look centered
            Text(' Monday'.tr()),
            Text('  Tuesday'.tr()),
            Text('Wednesday'.tr()),
            Text('Thursday '.tr()),
            Text('Friday   '.tr()),
            Text('Saturday '.tr()),
            Text('  Sunday '.tr()),
          ],
        ),
        Expanded(
          flex: 4,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 2,
              mainAxisExtent: 70,
            ),
            addAutomaticKeepAlives: true,
            addRepaintBoundaries: true,
            addSemanticIndexes: true,
            dragStartBehavior: DragStartBehavior.start,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            physics: const BouncingScrollPhysics(),
            reverse: false,
            scrollDirection: Axis.vertical,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            itemCount:
                DateUtils.getDaysInMonth(
                  _bloc!.currentYear,
                  _bloc!.currentMonth,
                ) +
                _firstMondayCounter,
            itemBuilder: (_, counter) {
              final int day = counter + 1;
              if (day < _firstMondayCounter) {
                final int daysInPreviousMonth = DateUtils.getDaysInMonth(
                  _bloc!.currentYear,
                  _bloc!.previousMonth,
                );
                return SizedBox(
                  width: 60,
                  height: 40,
                  child: CalendarListTile(
                    DateTime(
                      _bloc!.currentYear,
                      _bloc!.currentMonth - 1,
                      daysInPreviousMonth - (_firstMondayCounter - day - 1),
                    ),
                    previousMonth: true,
                  ),
                );
              } else {
                return SizedBox(
                  width: 60,
                  height: 40,
                  child: CalendarListTile(
                    DateTime(
                      _bloc!.currentYear,
                      _bloc!.currentMonth,
                      day - _firstMondayCounter + 1,
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }

  void _findFirstMonday() {
    for (int i = 1; i <= 7; i++) {
      final date = DateTime(_bloc!.currentYear, _bloc!.currentMonth, i);
      if (date.weekday == 1) {
        _firstMondayCounter = i;
        break;
      }
    }
  }
}
