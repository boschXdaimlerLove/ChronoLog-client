import 'package:chrono_log/models/events/event.dart';

final class LoginEvent extends Event {
  const LoginEvent(this.username);

  final String username;
}