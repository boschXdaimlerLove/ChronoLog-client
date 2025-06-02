import 'dart:io' show exit;

import 'package:flutter/material.dart' show Action, Intent;

class QuitIntent extends Intent {}

class QuitAction extends Action<QuitIntent> {
  @override
  Object? invoke(QuitIntent intent) {
    exit(0);
  }
}