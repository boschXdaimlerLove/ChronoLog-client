import 'package:flutter/material.dart';

final class TabSelectIntent extends Intent {}

final class TabSelectAction extends Action<TabSelectIntent> {
  @override
  Object? invoke(TabSelectIntent intent) {
    FocusScope.of(primaryFocus!.context!).nextFocus();
    return null;
  }
}