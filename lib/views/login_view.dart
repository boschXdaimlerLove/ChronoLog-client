import 'package:chrono_log/views/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:string_translate/string_translate.dart' show Translate;

final class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

final class _LoginViewState extends State<LoginView> {
  String username = "";

  String password = "";

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Spacer(flex: 1),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Login",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
            Text(
              "Log into your BBQ work account".tr(),
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
                  onSubmitted: (username) {},
                  enableIMEPersonalizedLearning: false,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    labelText: "Username".tr(),
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
                  onSubmitted: (password) {},
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  obscuringCharacter: '*',
                  enabled: true,
                  enableIMEPersonalizedLearning: false,
                  enableInteractiveSelection: true,
                  enableSuggestions: false,
                  decoration: InputDecoration(
                    labelText: "Password".tr(),
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    floatingLabelAlignment: FloatingLabelAlignment.start,
                  ),
                ),
              ),
            ),
            Spacer(flex: 2),
            TextButton(
              onPressed: () => login(),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 12,
                ),
                child: Text("Log in".tr()),
              ),
            ),
            Spacer(flex: 1),
          ],
        ),
      ),
    );
  }

  void login() {
    // TODO: implement login
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => Homescreen()));
  }
}
