import 'dart:async';

import 'package:chrono_log/blocs/event_bloc.dart';
import 'package:chrono_log/main.dart';
import 'package:chrono_log/models/events/event.dart';
import 'package:chrono_log/models/events/login_event.dart';
import 'package:chrono_log/models/events/logout_event.dart';
import 'package:flutter/material.dart';
import 'package:string_translate/string_translate.dart';

class MacosMenuWrapper extends StatefulWidget {
  const MacosMenuWrapper({
    super.key,
    required this.child,
    required this.reloadCallback,
    required this.context,
  });

  final Widget child;

  final Function() reloadCallback;

  final BuildContext context;

  @override
  State<MacosMenuWrapper> createState() => _MacosMenuWrapperState();
}

class _MacosMenuWrapperState extends State<MacosMenuWrapper> {
  bool _isLoggedIn = false;

  StreamSubscription<Event>? _eventSubscription;

  @override
  void initState() {
    _eventSubscription = EventBloc.eventStream.stream.listen((event) {
      if (event is LogoutEvent) {
        _isLoggedIn = false;
      } else if (event is LoginEvent) {
        _isLoggedIn = true;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isMacOS) {
      return PlatformMenuBar(
        menus: [_defaultMenu, _logOutMenu, _settingsMenu],
        child: widget.child,
      );
    } else {
      return widget.child;
    }
  }

  PlatformMenu get _defaultMenu {
    return PlatformMenu(
      label: 'Default'.tr(),
      menus: [
        PlatformMenuItemGroup(
          members: [
            PlatformMenuItem(
              label: 'About'.tr(),
              onSelected: () {
                showAboutDialog(context: widget.context);
              },
            ),
          ],
        ),
      ],
    );
  }

  PlatformMenu get _logOutMenu {
    return PlatformMenu(
      label: 'User'.tr(),
      menus: [
        PlatformMenuItem(
          label: 'Log out'.tr(),
          onSelected:
              _isLoggedIn
                  ? () {
                    EventBloc.eventStream.sink.add(const LogoutEvent());
                  }
                  : null,
        ),
      ],
    );
  }

  PlatformMenu get _settingsMenu {
    return PlatformMenu(
      label: 'Settings'.tr(),
      menus: [
        PlatformMenuItemGroup(
          members: [
            PlatformMenu(
              label: 'Change language'.tr(),
              menus: [
                PlatformMenuItem(
                  label: 'English'.tr(),
                  onSelected: () {
                    setState(() {
                      Translation.changeLanguage(TranslationLocales.english);
                      widget.reloadCallback();
                    });
                  },
                ),
                PlatformMenuItem(
                  label: 'German'.tr(),
                  onSelected: () {
                    setState(() {
                      Translation.changeLanguage(TranslationLocales.german);
                      widget.reloadCallback();
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    _eventSubscription?.cancel();
    super.dispose();
  }
}