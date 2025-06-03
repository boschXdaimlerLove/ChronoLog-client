import 'package:chrono_log/models/events/event.dart';
import 'package:chrono_log/models/notification.dart';

final class NotificationTriggeredEvent extends Event {
  final Notification notification;

  NotificationTriggeredEvent(this.notification);
}