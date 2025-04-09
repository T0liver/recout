import "package:flutter/material.dart";
import "package:recout/button.dart";
import "package:recout/l10n/l10n.dart";
import "package:recout/labels.dart";
import "package:recout/texts.dart";

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _unamecontroller = TextEditingController();
  final TextEditingController _passcontroller = TextEditingController();
  final TextEditingController _emailcontroller = TextEditingController();
  String _username = '';
  String _password = '';
  String _emailadr = '';

  void getCredentials() {
    setState(() {
      _username = _unamecontroller.text;
      _password = _passcontroller.text;
      _emailadr = _emailcontroller.text;
    });
    debugPrint("Username: $_username    E-mail: $_emailadr    Password: $_password");
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
                  Heading(text: l10n.register),
                  const Spacer(flex: 3),
                  TextLabel(controller: _unamecontroller, hint: l10n.username),
                  const SizedBox(height: 20),
                  TextLabel(controller: _emailcontroller, hint: l10n.emailaddr),
                  const SizedBox(height: 20),
                  PasswordLabel(controller: _passcontroller, hint: l10n.password),
                  const Spacer(flex: 2),
                  Button(text: l10n.goalright, onPressed: getCredentials),
                  const Spacer(flex: 1,)
                ]
            )
        )
    );
  }
}