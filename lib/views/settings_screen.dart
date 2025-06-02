import 'package:chrono_log/blocs/settings_bloc.dart';
import 'package:flutter/cupertino.dart' show CupertinoIcons;
import 'package:flutter/material.dart';
import 'package:string_translate/string_translate.dart' show Translate;

final class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: Text('Change password'.tr()),
          subtitle: Text('Change your login password'.tr()),
          leading: Icon(Icons.password),
          onTap: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => Dialog(child: PasswordSettingsScreen()),
              ),
            );
          },
        ),
        ListTile(
          title: Text('Change language'.tr()),
          subtitle: Text('Change the display language of the app'.tr()),
          leading: Icon(CupertinoIcons.globe),
        ),
      ],
    );
  }
}

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

  @override
  Widget build(BuildContext context) {
    //_bloc ??= BlocParent.of(context);
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 400, maxWidth: 600),
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
              TextButton(
                onPressed: () => _bloc!.submit(),
                child: Text('submit'.tr()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LanguageSettingsScreen extends StatelessWidget {
  const LanguageSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}