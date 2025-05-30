// Generated by Hive CE
// Do not modify
// Check in to version control

import 'package:hive_ce/hive.dart';
import 'package:chrono_log/models/notification.dart';
import 'package:chrono_log/models/time_frame.dart';

extension HiveRegistrar on HiveInterface {
  void registerAdapters() {
    registerAdapter(NotificationAdapter());
    registerAdapter(TimeFrameAdapter());
  }
}

extension IsolatedHiveRegistrar on IsolatedHiveInterface {
  void registerAdapters() {
    registerAdapter(NotificationAdapter());
    registerAdapter(TimeFrameAdapter());
  }
}
