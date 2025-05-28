import 'package:chrono_log/errors/cross_day_time_frame_error.dart';
import 'package:chrono_log/errors/time_frame_json_format_error.dart';
import 'package:hive_ce_flutter/hive_flutter.dart'
    show BinaryReader, BinaryWriter, HiveField, HiveType, TypeAdapter;

part 'time_frame.g.dart';

@HiveType(typeId: 0)
final class TimeFrame {
  @HiveField(0)
  DateTime start;

  @HiveField(1)
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

  String getWorkingTimeRepresentation() {
    String res = '';
    final Duration duration = getWorkingTime();
    res += duration.inHours.toString().padLeft(2, '0');
    res += 'h ';
    res += duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    res += 'm';
    return res;
  }

  Map<String, dynamic> toJSON() {
    return {
      'start': start.toUtc().toIso8601String(),
      'end': end.toUtc().toIso8601String(),
    };
  }

  @override
  String toString() {
    return '''
    TimeFrame:
    start: $start,
    end: $end,
    duration: ${getWorkingTimeRepresentation()}
    ''';
  }
}