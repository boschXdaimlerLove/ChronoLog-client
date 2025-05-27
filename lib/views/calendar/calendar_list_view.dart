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

  @override
  Widget build(BuildContext context) {
    _bloc ??= BlocParent.of(context);

    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
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
        Flexible(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              mainAxisExtent: 50,
              maxCrossAxisExtent: 100,
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
            itemCount: DateUtils.getDaysInMonth(
              _bloc!.currentYear,
              _bloc!.currentMonth,
            ),
            itemBuilder: (_, counter) {
              int day = counter + 1;
              return SizedBox(
                width: 60,
                height: 40,
                child: CalendarListTile(
                  DateTime(_bloc!.currentYear, _bloc!.currentMonth, day),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}