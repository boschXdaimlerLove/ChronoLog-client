import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';

import 'calendar_list_tile.dart';

final class CalendarListView extends StatelessWidget {
  const CalendarListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
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
        DateTime.now().year,
        DateTime.now().month,
      ),
      itemBuilder: (_, counter) {
        return SizedBox(
          width: 60,
          height: 40,
          child: CalendarListTile(
            DateTime(DateTime.now().year, DateTime.now().month, counter + 1),
          ),
        );
      },
    );
  }
}
