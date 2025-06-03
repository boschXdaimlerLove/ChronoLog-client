import 'package:chrono_log/models/events/event.dart';

final class ChangePasswordEvent extends Event {
  final String password;

  ChangePasswordEvent(this.password);
}