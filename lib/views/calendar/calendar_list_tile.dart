import 'package:flutter/material.dart';

class CalendarListTile extends StatelessWidget {
  const CalendarListTile(this.date, {super.key});

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(25)),
        shape: BoxShape.rectangle,
        color: Colors.green,
      ),
      child: Center(child: Text("${date.day}")),
    );
  }
}
