import 'package:bloc_implementation/bloc_implementation.dart' show BlocParent;
import 'package:chrono_log/blocs/event_bloc.dart';
import 'package:chrono_log/blocs/settings_bloc.dart';
import 'package:chrono_log/models/events/logout_event.dart';
import 'package:chrono_log/views/dialogs/settings_screen.dart'
    show PasswordSettingsScreen;
import 'package:flutter/material.dart';
import 'package:string_translate/string_translate.dart'
    show Translate, Translation, TranslationLocales;

final class TopBar extends StatefulWidget {
  const TopBar({
    super.key,
    this.navigateBack,
    this.loggedIn = true,
    required this.refreshCallback,
  });

  final Function()? navigateBack;

  final bool loggedIn;

  final Function() refreshCallback;

  @override
  State<TopBar> createState() => _TopBarState();
}

final class _TopBarState extends State<TopBar> {
  final LayerLink _link = LayerLink();
  OverlayEntry? _settingsMenuOverlay;
  OverlayEntry? _languageSettingsSubMenuOverlay;

  /* Main Menu */

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _link,
      child: SizedBox(
        height: 30,
        child: DecoratedBox(
          decoration: BoxDecoration(color: Colors.blueGrey.shade300),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _backNavigation,
              _logoutBtn,
              TextButton(
                onPressed: _toggleSettingsMenu,
                child: Text('Settings'.tr(), style: _barTextStyle),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget get _backNavigation {
    if (widget.navigateBack != null) {
      return TextButton(
        onPressed: widget.navigateBack,
        child: Text('Back'.tr(), style: _barTextStyle),
      );
    } else {
      return Container();
    }
  }

  Widget get _logoutBtn {
    if (widget.loggedIn) {
      return TextButton(
        onPressed: _showLogoutDialog,
        child: Text('Log out'.tr(), style: _barTextStyle),
      );
    } else {
      return Container();
    }
  }

  /* Sub Menus & actions */

  void _toggleSettingsMenu() {
    if (_settingsMenuOverlay != null) {
      _removeSettingsMenu();
      return;
    }
    final OverlayState overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);

    _settingsMenuOverlay = OverlayEntry(
      builder: (_) {
        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                onTap: _removeSettingsMenu,
                behavior: HitTestBehavior.translucent,
              ),
            ),
            Positioned(
              width: 300,
              left: position.dx,
              child: CompositedTransformFollower(
                link: _link,
                showWhenUnlinked: false,
                offset: Offset(widget.loggedIn ? 80 : 0, 30),
                child: Material(
                  elevation: 4,
                  child: DecoratedBox(
                    decoration: BoxDecoration(shape: BoxShape.rectangle),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: Text(
                            'change language'.tr(),
                            style: _textStyle,
                          ),
                          onTap: _toggleLanguageSettingsSubMenu,
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black26,
                          ),
                        ),
                        _changePasswordTile,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
    overlay.insert(_settingsMenuOverlay!);
  }

  void _removeSettingsMenu() {
    _settingsMenuOverlay!.remove();
    _settingsMenuOverlay = null;
  }

  void _removeLanguageSubSettingsMenu() {
    _languageSettingsSubMenuOverlay!.remove();
    _languageSettingsSubMenuOverlay = null;
    _removeSettingsMenu();
  }

  void _toggleLanguageSettingsSubMenu() {
    if (_languageSettingsSubMenuOverlay != null) {
      _removeLanguageSubSettingsMenu();
      return;
    }
    final OverlayState overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);

    _languageSettingsSubMenuOverlay = OverlayEntry(
      builder: (_) {
        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                onTap: _removeLanguageSubSettingsMenu,
                behavior: HitTestBehavior.translucent,
              ),
            ),
            Positioned(
              width: 300,
              left: position.dx,
              child: CompositedTransformFollower(
                link: _link,
                showWhenUnlinked: false,
                offset: Offset(widget.loggedIn ? 380 : 300, 30),
                child: Material(
                  elevation: 4,
                  child: DecoratedBox(
                    decoration: BoxDecoration(shape: BoxShape.rectangle),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: Text('English'.tr(), style: _textStyle),
                          leading: Text('🇬🇧'),
                          onTap: () {
                            setState(() {
                              _removeLanguageSubSettingsMenu();
                              Translation.changeLanguage(
                                TranslationLocales.english,
                              );
                            });
                            widget.refreshCallback();
                          },
                        ),
                        Divider(),
                        ListTile(
                          title: Text('German'.tr(), style: _textStyle),
                          leading: Text('🇩🇪'),
                          onTap: () {
                            setState(() {
                              _removeLanguageSubSettingsMenu();
                              Translation.changeLanguage(
                                TranslationLocales.german,
                              );
                            });
                            widget.refreshCallback();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
    overlay.insert(_languageSettingsSubMenuOverlay!);
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text('log out?'.tr()),
          content: Text(
            'Do you really want to log out?\nYou\'ll have to log in again '
                    'to use the services'
                .tr(),
            textAlign: TextAlign.start,
          ),
          actions: <TextButton>[
            TextButton(
              onPressed: () {
                EventBloc.eventStream.sink.add(const LogoutEvent());
              },
              child: Text('Log out'.tr()),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'.tr()),
            ),
          ],
        );
      },
    );
  }

  Widget get _changePasswordTile {
    if (widget.loggedIn) {
      return ListTile(
        title: Text('change password'.tr(), style: _textStyle),
        onTap: () {
          setState(() {
            _toggleSettingsMenu();
            showDialog(
              context: context,
              builder: (_) {
                return Dialog(
                  child: BlocParent(
                    bloc: SettingsBloc(
                      'user' /* TODO:
                                      insert username here */,
                    ),
                    child: PasswordSettingsScreen(),
                  ),
                );
              },
            );
          });
        },
      );
    } else {
      return Container();
    }
  }

  /* TEXT STYLES */

  TextStyle get _barTextStyle {
    return TextStyle(
      fontSize: 16,
      color: Colors.white,
      fontWeight: FontWeight.w300,
    );
  }

  TextStyle get _textStyle {
    return TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w300,
      fontStyle: FontStyle.normal,
      color: Colors.black87,
    );
  }

  @override
  void dispose() {
    _settingsMenuOverlay?.remove();
    super.dispose();
  }
}