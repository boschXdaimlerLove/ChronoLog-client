import 'package:flutter/material.dart';

class CalendarListView extends StatelessWidget {
  const CalendarListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Placeholder();
    ListView.builder(
      addAutomaticKeepAlives: true,
      addRepaintBoundaries: true,
      addSemanticIndexes: true,
      hitTestBehavior: HitTestBehavior.deferToChild,
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      physics: const BouncingScrollPhysics(),
      itemCount: 10,
      itemBuilder: (context, counter) {
        return ListTile();
      },
    );
  }
}