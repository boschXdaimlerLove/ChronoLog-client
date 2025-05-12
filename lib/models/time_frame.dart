final class TimeFrame {
  DateTime start;
  DateTime end;

  TimeFrame(this.start, this.end) {
    if (start.year != end.year ||
        start.month != end.month ||
        start.day != end.day) {
      // TODO: throw error
    }
  }

  factory TimeFrame.fromJSON(Map<String, dynamic> json) {
    return switch (json) {
      {'start': String startTime, 'end': String endTime} => TimeFrame(
        DateTime.parse(startTime),
        DateTime.parse(endTime),
      ),
      // TODO: update exception
      _ => throw Exception(),
    };
  }

  Duration getWorkingTime() {
    return start.difference(end);
  }

  String toJSON() {
    return "{start:${start.toIso8601String()}, end:${end.toIso8601String()}";
  }
}
