import 'dart:io' show Platform;

import 'package:bloc_implementation/bloc_implementation.dart' show BlocParent;
import 'package:chrono_log/api/api_calls.dart';
import 'package:chrono_log/api/server_communication.dart';
import 'package:chrono_log/blocs/home_bloc.dart';
import 'package:chrono_log/main.dart';
import 'package:chrono_log/models/time_frame.dart';
import 'package:chrono_log/storage/storage.dart';
import 'package:chrono_log/views/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    show MacOSFlutterLocalNotificationsPlugin;
import 'package:string_translate/string_translate.dart' show Translate;

final class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

final class _LoginViewState extends State<LoginView> {
  Future<void> _requestPermissions() async {
    if (Platform.isMacOS) {
      flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
            MacOSFlutterLocalNotificationsPlugin
          >()
          ?.requestPermissions(alert: true, badge: true, sound: true);
    }
  }

  String username = '';

  String password = '';

  HomeBloc? _bloc;

  FocusManager _focusManager = FocusManager();

  FocusNode _usernameNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    /* LOCAL NOTIFICATIONS PLUGIN */
    _requestPermissions();
    _bloc ??= BlocParent.of(context);

    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            _topBar,
            Spacer(flex: 1),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Login'.tr(),
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
            Text(
              'Log into your BBQ work account'.tr(),
              style: TextStyle(
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w300,
                fontSize: 16,
              ),
            ),
            Spacer(flex: 1),
            Icon(Icons.person, size: 64),
            Spacer(flex: 1),
            SizedBox(
              width: size.width / 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 64.0,
                  vertical: 16,
                ),
                child: TextField(
                  focusNode: _usernameNode,
                  onChanged:
                      (username) => setState(() => this.username = username),
                  enableIMEPersonalizedLearning: false,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    labelText: 'Username'.tr(),
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    floatingLabelAlignment: FloatingLabelAlignment.start,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: size.width / 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 64.0,
                  vertical: 16,
                ),
                child: TextField(
                  onChanged:
                      (password) => setState(() => this.password = password),
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  obscuringCharacter: '*',
                  enabled: true,
                  enableIMEPersonalizedLearning: false,
                  enableInteractiveSelection: true,
                  enableSuggestions: false,
                  decoration: InputDecoration(
                    labelText: 'Password'.tr(),
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    floatingLabelAlignment: FloatingLabelAlignment.start,
                  ),
                ),
              ),
            ),
            Spacer(flex: 2),
            TextButton(
              onPressed: _loginEnabled ? () => _login() : null,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 12,
                ),
                child: Text('Log in'.tr()),
              ),
            ),
            Spacer(flex: 1),
          ],
        ),
      ),
    );
  }

  bool get _loginEnabled {
    return username.isNotEmpty && password.isNotEmpty;
  }

  Widget get _topBar {
    if (isWindowsOrLinux) {
      return TopBar(loggedIn: false, refreshCallback: () => setState(() {}));
    } else {
      return Container();
    }
  }

  void _login() async {
    bool correct = false;
    String error = '';
    try {
      List<TimeFrame> frames = await ServerCommunication.getTimes(
        username,
        password,
      );
      for (TimeFrame frame in frames) {
        await Storage.storeNewTime(frame);
      }
      correct = true;
    } catch (e) {
      error = e.toString();
      correct = false;
    }
    if (correct) {
      _bloc!.login(username, password);
      if (mounted) {
        /*
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => BlocParent(bloc: _bloc!, child: Homescreen()),
          ),
        );
        */
      }
    } else {
      if (mounted) {
        showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text(
                'Login error'.tr(),
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              content: Text(
                'There\'s been an error logging you in.\nYou either entered the wrong login data, or there is no internet connection. $error with connection ${APICalls.getGetTimesAPICall()}',
                style: TextStyle(fontWeight: FontWeight.w300),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _login();
                  },
                  child: Text('Try again'.tr()),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Close'.tr()),
                ),
              ],
            );
          },
        );
      }
    }
  }
}