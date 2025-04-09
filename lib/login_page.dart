import "package:flutter/material.dart";
import "package:recout/button.dart";
import "package:recout/l10n/l10n.dart";
import "package:recout/labels.dart";
import "package:recout/texts.dart";

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _unamecontroller = TextEditingController();
  final TextEditingController _passcontroller = TextEditingController();
  String _username = '';
  String _password = '';

  void getCredentials() {
    setState(() {
      _username = _unamecontroller.text;
      _password = _passcontroller.text;
    });
    debugPrint("Username: $_username    Password: $_password");
  }

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context)!;
    return(
      Scaffold(
          body: Column(
              children: [
                const SizedBox(height: 10,),
                const BackBtn(),
                const Spacer(flex: 2),
                Image.asset('assets/graphics/icons/icons8-strong-arm-128.png', height: MediaQuery.sizeOf(context).height * 0.15,),
                Heading(text: l10n.login),
                const Spacer(flex: 3),
                TextLabel(controller: _unamecontroller, hint: l10n.username),
                const SizedBox(height: 20),
                PasswordLabel(controller: _passcontroller, hint: l10n.password),
                const Spacer(flex: 2),
                Button(text: l10n.letsgo, onPressed: getCredentials),
                const Spacer(flex: 1,)
              ]
          )
      )
    );
  }
}