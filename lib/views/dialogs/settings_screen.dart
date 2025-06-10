import 'package:bloc_implementation/bloc_implementation.dart' show BlocParent;
import 'package:chrono_log/blocs/settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:string_translate/string_translate.dart' show Translate;

final class PasswordSettingsScreen extends StatefulWidget {
  const PasswordSettingsScreen({super.key});

  @override
  State<PasswordSettingsScreen> createState() => _PasswordSettingsScreenState();
}

final class _PasswordSettingsScreenState extends State<PasswordSettingsScreen> {
  SettingsBloc? _bloc;

  bool _oldPasswordObscured = true;

  bool _newPasswordObscured = true;

  bool _newPasswordConfirmObscured = true;

  final RegExp regex = RegExp(
    '^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^A-Za-z0-9]).{12,}\$',
  );

  @override
  Widget build(BuildContext context) {
    _bloc ??= BlocParent.of(context);
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 475, maxWidth: 600),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 24,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    'Change password'.tr(),
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
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
                onChanged:
                    (oldPassword) =>
                        setState(() => _bloc!.oldPassword = oldPassword),
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
                onChanged:
                    (newPassword) =>
                        setState(() => _bloc!.newPassword = newPassword),
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
                onChanged:
                    (newPasswordConfirm) => setState(
                      () => _bloc!.newPasswordConfirm = newPasswordConfirm,
                    ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'The new password must contain the following:'.tr(),
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text('- 1 capital letter'.tr()),
                      Text('- 1 lowercase letter'.tr()),
                      Text('- 1 number'.tr()),
                      Text('- 1 special character'.tr()),
                    ],
                  ),
                ],
              ),
              TextButton(
                onPressed:
                    _submitEnabled
                        ? () {
                          _bloc!.submit();
                          Navigator.of(context).pop();
                        }
                        : null,
                child: Text('submit'.tr()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool get _submitEnabled {
    if (regex.hasMatch(_bloc!.newPassword)) {
      return _bloc!.newPassword == _bloc!.newPasswordConfirm;
    } else {
      return false;
    }
  }
}