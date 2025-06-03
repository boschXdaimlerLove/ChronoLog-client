import 'package:flutter/material.dart';

class EscapeIntent extends Intent {
  const EscapeIntent(this.navigatorKey);

  final GlobalKey<NavigatorState> navigatorKey;
}

class EscapeAction extends Action<EscapeIntent> {
  @override
  Object? invoke(EscapeIntent intent) {
    if (intent.navigatorKey.currentState!.canPop()) {
      Navigator.of(intent.navigatorKey.currentContext!).pop();
    }
    return null;
  }
}