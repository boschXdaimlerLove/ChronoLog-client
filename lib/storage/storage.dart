import 'dart:collection' show UnmodifiableListView;

import 'package:chrono_log/models/time_frame.dart';
import 'package:hive_ce_flutter/adapters.dart';

final class Storage {
  static Box<TimeFrame>? _frameBox;

  /// The Key for the [_frameBox]
  static const String _frameBoxKey = 'TimeFrame Box';

  static final List<TimeFrame> _frameList = [];

  static UnmodifiableListView<TimeFrame> get frames =>
      UnmodifiableListView(_frameList);

  static Future<void> init() async {
    Hive.registerAdapter(TimeFrameAdapter());
    _frameBox = await Hive.openBox<TimeFrame>(_frameBoxKey);
    _loadTimes();
    //_frameList.add(TimeFrame(DateTime.now(), DateTime.now()));
    //_frameList.add(TimeFrame(DateTime.now(), DateTime.now()));
  }

  static void _loadTimes() {
    for (TimeFrame frame in _frameBox!.values) {
      _frameList.add(frame);
    }
  }

  static void storeNewTime(TimeFrame time) {
    _frameList.add(time);
    _frameBox!.deleteAll(_frameBox!.keys);
    for (int i = 0; i < _frameList.length; i++) {
      final String key = 'TimeFrame $i';
      _frameBox!.put(key, _frameList[i]);
    }
  }

  static List<TimeFrame> getFramesForDay(final DateTime date) {
    return _frameList.where((frame) => _frameInDay(frame, date)).toList();
  }

  static bool _frameInDay(final TimeFrame frame, final DateTime date) {
    return frame.start.day == date.day &&
        frame.start.month == date.month &&
        frame.start.year == date.year;
  }
}