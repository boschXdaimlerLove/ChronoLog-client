import 'dart:collection' show UnmodifiableListView;

import 'package:chrono_log/models/notification.dart';
import 'package:chrono_log/models/time_frame.dart';
import 'package:hive_ce_flutter/adapters.dart';

final class Storage {
  static Box<TimeFrame>? _frameBox;

  static Box<Notification>? _notificationBox;

  /// The Key for the [_frameBox]
  static const String _frameBoxKey = 'TimeFrame Box';

  static const String _notificationBoxKey = 'Notification Box';

  static final List<TimeFrame> _frameList = [];

  static final List<Notification> _notificationList = [];

  static UnmodifiableListView<TimeFrame> get frames =>
      UnmodifiableListView(_frameList);

  static UnmodifiableListView<Notification> get notifications =>
      UnmodifiableListView(_notificationList);

  static Future<void> init() async {
    Hive.registerAdapter(TimeFrameAdapter());
    Hive.registerAdapter(NotificationAdapter());
    _frameBox = await Hive.openBox<TimeFrame>(_frameBoxKey);
    _notificationBox = await Hive.openBox<Notification>(_notificationBoxKey);
    await _frameBox!.clear();
    _loadTimes();
    _loadNotifications();
  }

  static void _loadTimes() {
    for (TimeFrame frame in _frameBox!.values) {
      _frameList.add(frame);
    }
  }

  static void _loadNotifications() {
    _notificationList.add(
      Notification(
        'Test notification',
        'This is a long test notification to test notifications LOL',
        read: true,
      ),
    );
    _notificationList.add(
      Notification(
        'Test notification',
        'This is a long test notification to test notifications LOL',
      ),
    );
    for (Notification not in _notificationBox!.values) {
      _notificationList.add(not);
    }
  }

  static void deleteNotification(Notification notification) async {
    final int index = _notificationList.indexOf(notification);
    _notificationList.remove(notification);
    await _notificationBox!.delete('Notification $index');
  }

  static Future<void> storeNewNotification(Notification notification) async {
    _notificationList.add(notification);
    await _notificationBox!.clear();
    for (int i = 0; i < _notificationList.length; i++) {
      final String key = 'Notification $i';
      await _notificationBox!.put(key, _notificationList[i]);
    }
  }

  static Future<void> storeNewTime(TimeFrame time) async {
    _frameList.add(time);
    await _frameBox!.clear();
    for (int i = 0; i < _frameList.length; i++) {
      final String key = 'TimeFrame $i';
      await _frameBox!.put(key, _frameList[i]);
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