import 'package:chrono_log/errors/cross_day_time_frame_error.dart';
import 'package:chrono_log/errors/time_frame_json_format_error.dart';

final class TimeFrame {
  DateTime start;
  DateTime end;

  TimeFrame(this.start, this.end) {
    if (start.year != end.year ||
        start.month != end.month ||
        start.day != end.day) {
      throw CrossDayTimeFrameError();
    }
  }

  factory TimeFrame.fromJSON(Map<String, dynamic> json) {
    return switch (json) {
      {'start': String startTime, 'end': String endTime} => TimeFrame(
        DateTime.parse(startTime),
        DateTime.parse(endTime),
      ),
      _ => throw TimeFrameJsonFormatError(),
    };
  }

  Duration getWorkingTime() {
    return start.difference(end);
  }

  String toJSON() {
    return "{start:${start.toIso8601String()}, end:${end.toIso8601String()}";
  }
}
