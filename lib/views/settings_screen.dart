import 'package:flutter/material.dart';

final class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

final class _SettingsScreenState extends State<SettingsScreen> {
  String oldPassword = "";

  String newPassword = "";

  String newPasswordConfirm = "";

  bool oldPasswordObscured = true;

  bool newPasswordObscured = true;

  bool newPasswordConfirmObscured = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(labelText: "Old Password"),
              obscureText: oldPasswordObscured,
              obscuringCharacter: '*',
              onSubmitted: (oldPassword) => this.oldPassword = oldPassword,
            ),
            TextField(
              decoration: InputDecoration(labelText: "New Password"),
              obscureText: newPasswordObscured,
              obscuringCharacter: '*',
              onSubmitted: (newPassword) => this.newPassword = newPassword,
            ),
            TextField(
              decoration: InputDecoration(labelText: "Confirm new Password"),
              obscureText: newPasswordConfirmObscured,
              obscuringCharacter: '*',
              onSubmitted:
                  (newPasswordConfirm) =>
                      this.newPasswordConfirm = newPasswordConfirm,
            ),
          ],
        ),
      ),
    );
  }
}
