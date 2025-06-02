import 'dart:async' show StreamController;

import 'package:bloc_implementation/bloc_implementation.dart' show Bloc;
import 'package:chrono_log/models/events/event.dart';

final class EventBloc extends Bloc {
  static final StreamController<Event> _eventStream =
      StreamController<Event>.broadcast();

  static StreamController<Event> get eventStream => _eventStream;

  @override
  void dispose() {
    _eventStream.close();
  }
}