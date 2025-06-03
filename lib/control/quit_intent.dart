import 'dart:io' show exit;

import 'package:chrono_log/main.dart';
import 'package:flutter/material.dart' show Action, Intent;

class QuitIntent extends Intent {}

class QuitAction extends Action<QuitIntent> {
  @override
  Object? invoke(QuitIntent intent) {
    if (isMacOS) {
      exit(0);
    }
    return null;
  }
}