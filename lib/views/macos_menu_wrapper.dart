import 'dart:async' show StreamSubscription;

import 'package:bloc_implementation/bloc_implementation.dart' show BlocParent;
import 'package:chrono_log/blocs/event_bloc.dart';
import 'package:chrono_log/main.dart';
import 'package:chrono_log/models/events/event.dart';
import 'package:chrono_log/models/events/login_event.dart';
import 'package:chrono_log/models/events/logout_event.dart';
import 'package:chrono_log/models/events/notification_triggered_event.dart';
import 'package:chrono_log/models/notification.dart';
import 'package:flutter/material.dart' hide Notification;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:string_translate/string_translate.dart'
    show Translate, Translation, TranslationLocales;

import '../blocs/settings_bloc.dart';
import 'dialogs/settings_screen.dart';

final class MacosMenuWrapper extends StatefulWidget {
  const MacosMenuWrapper({
    super.key,
    required this.child,
    required this.reloadCallback,
    required this.navigatorKey,
  });

  final Widget child;

  final Function() reloadCallback;

  final GlobalKey<NavigatorState> navigatorKey;

  @override
  State<MacosMenuWrapper> createState() => _MacosMenuWrapperState();
}

class _MacosMenuWrapperState extends State<MacosMenuWrapper> {
  bool _isLoggedIn = false;

  StreamSubscription<Event>? _eventSubscription;

  String _username = '';

  @override
  void initState() {
    _eventSubscription = EventBloc.eventStream.stream.listen((event) {
      if (event is LogoutEvent) {
        _isLoggedIn = false;
      } else if (event is LoginEvent) {
        _isLoggedIn = true;
        _username = event.username;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isMacOS) {
      return PlatformMenuBar(
        menus: [_defaultMenu, _logOutMenu, _settingsMenu, _debugMenu],
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
                showAboutDialog(
                  context: widget.navigatorKey.currentContext!,
                  applicationName: 'ChronoLog',
                  applicationLegalese: '© 2025 ChronoLog Team',
                  applicationVersion: '1.0.0',
                  applicationIcon: Image.asset(
                    'assets/app_icon.png',
                    width: 50,
                    height: 50,
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Divider(),
                    ),
                    Text('More information', style: TextStyle(fontSize: 18)),
                    Text(
                      'This software is only developed for a project for the bachelor of science on the DHBW Stuttgart.\nIt is not applicable for commercial use.',
                    ),
                  ],
                );
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
            PlatformMenuItem(
              label: 'Change password'.tr(),
              onSelected:
                  _isLoggedIn
                      ? () {
                        showDialog(
                          context: widget.navigatorKey.currentContext!,
                          builder: (_) {
                            return Dialog(
                              child: BlocParent(
                                bloc: SettingsBloc(_username),
                                child: PasswordSettingsScreen(),
                              ),
                            );
                          },
                        );
                      }
                      : null,
            ),
          ],
        ),
      ],
    );
  }

  PlatformMenu get _debugMenu {
    return PlatformMenu(
      label: 'Debug',
      menus: [
        PlatformMenuItem(
          label: 'Show notification',
          onSelected: () {
            flutterLocalNotificationsPlugin.show(
              UniqueKey().hashCode,
              'Debug Notification',
              'This is a debug notification shown to test the plugin',
              NotificationDetails(
                macOS: DarwinNotificationDetails(presentBadge: true),
                windows: WindowsNotificationDetails(
                  duration: WindowsNotificationDuration.long,
                ),
                linux: LinuxNotificationDetails(
                  category: LinuxNotificationCategory.presence,
                ),
              ),
            );
            EventBloc.eventStream.sink.add(
              NotificationTriggeredEvent(
                Notification('Debug notification', ('Debugging..')),
              ),
            );
          },
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