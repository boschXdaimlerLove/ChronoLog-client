import 'package:bloc_implementation/bloc_implementation.dart' show BlocParent;
import 'package:chrono_log/blocs/settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:string_translate/string_translate.dart' show Translate;

final class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

final class _SettingsScreenState extends State<SettingsScreen> {
  SettingsBloc? _bloc;

  bool _oldPasswordObscured = true;

  bool _newPasswordObscured = true;

  bool _newPasswordConfirmObscured = true;

  @override
  Widget build(BuildContext context) {
    _bloc ??= BlocParent.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        foregroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text('Settings'.tr()),
        automaticallyImplyLeading: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 64.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 24,
            children: [
              Spacer(flex: 3),
              TextField(
                enableIMEPersonalizedLearning: false,
                enableInteractiveSelection: true,
                enableSuggestions: false,
                decoration: InputDecoration(
                  labelText: 'current password'.tr(),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  floatingLabelAlignment: FloatingLabelAlignment.start,
                  suffixIcon: IconButton(
                    style: ButtonStyle(
                      foregroundColor: WidgetStatePropertyAll(Colors.black),
                    ),
                    onPressed: () {
                      setState(() {
                        _oldPasswordObscured = !_oldPasswordObscured;
                      });
                    },
                    icon: Icon(
                      _oldPasswordObscured
                          ? Icons.panorama_fish_eye
                          : Icons.hide_source,
                    ),
                  ),
                ),
                obscureText: _oldPasswordObscured,
                obscuringCharacter: '*',
                onSubmitted: (oldPassword) => _bloc!.oldPassword = oldPassword,
              ),
              TextField(
                enableIMEPersonalizedLearning: false,
                enableInteractiveSelection: true,
                enableSuggestions: false,
                decoration: InputDecoration(
                  labelText: 'new password'.tr(),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  floatingLabelAlignment: FloatingLabelAlignment.start,
                  suffixIcon: IconButton(
                    style: ButtonStyle(
                      foregroundColor: WidgetStatePropertyAll(Colors.black),
                    ),
                    onPressed: () {
                      setState(() {
                        _newPasswordObscured = !_newPasswordObscured;
                      });
                    },
                    icon: Icon(
                      _newPasswordObscured
                          ? Icons.panorama_fish_eye
                          : Icons.hide_source,
                    ),
                  ),
                ),
                obscureText: _newPasswordObscured,
                obscuringCharacter: '*',
                onSubmitted: (newPassword) => _bloc!.newPassword = newPassword,
              ),
              TextField(
                enableIMEPersonalizedLearning: false,
                enableInteractiveSelection: true,
                enableSuggestions: false,
                decoration: InputDecoration(
                  labelText: 'Confirm new password'.tr(),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  floatingLabelAlignment: FloatingLabelAlignment.start,
                  suffixIcon: IconButton(
                    style: ButtonStyle(
                      foregroundColor: WidgetStatePropertyAll(Colors.black),
                    ),
                    onPressed: () {
                      setState(() {
                        _newPasswordConfirmObscured =
                            !_newPasswordConfirmObscured;
                      });
                    },
                    icon: Icon(
                      _newPasswordConfirmObscured
                          ? Icons.panorama_fish_eye
                          : Icons.hide_source,
                    ),
                  ),
                ),
                obscureText: _newPasswordConfirmObscured,
                obscuringCharacter: '*',
                onSubmitted:
                    (newPasswordConfirm) =>
                        _bloc!.newPasswordConfirm = newPasswordConfirm,
              ),
              Spacer(flex: 2),
              TextButton(
                onPressed: () => _bloc!.submit(),
                child: Text('Submit'.tr()),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}