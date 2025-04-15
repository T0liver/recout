import "package:flutter/material.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:recout/globals.dart";

import "package:recout/l10n/l10n.dart";

import "package:recout/button.dart";
import "package:recout/labels.dart";
import "package:recout/texts.dart";
import "package:recout/user.dart";

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _unamecontroller = TextEditingController();
  final TextEditingController _passcontroller = TextEditingController();
  final TextEditingController _emailcontroller = TextEditingController();

  bool _isLoading = false;

  Future<void> getCredentials() async {
    final l10n = L10n.of(context)!;

    setState(() {
      _isLoading = true;
    });

    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailcontroller.text.trim(),
        password: _passcontroller.text.trim(),
      );

      await FirebaseFirestore.instance
          .collection('users')
          .doc(credential.user!.uid)
          .set({
        'username': _unamecontroller.text.trim(),
        'email': _emailcontroller.text.trim(),
        'createdAt': Timestamp.now(),
      });
      
      Globals.user = UserR(userid: credential.user!.uid, username: _unamecontroller.text.trim(), email: _emailcontroller.text.trim());
      Globals.login();

      if (mounted) {
        Navigator.pushReplacementNamed(context, '/');
      }
    } on FirebaseAuthException catch (e) {
      String msg;
      switch (e.code) {
        case 'email-already-in-use':
          msg = l10n.emailAlreadyInUse;
          break;
        case 'invalid-email':
          msg = l10n.invalidEmail;
          break;
        case 'weak-password':
          msg = l10n.weakPassword;
          break;
        default:
          msg = '${l10n.unknownError}: ${e.message}';
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(msg)),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
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
                  Button(
                    text: _isLoading ? '...' : l10n.goalright,
                    onPressed: () {
                      if (!_isLoading) {
                        getCredentials();
                      }
                    },
                    bgColor: _isLoading ? const Color(0x99F9DC5C) : const Color(0xFFF9DC5C),
                  ),
                  const Spacer(flex: 1,)
                ]
            )
        )
    );
  }
}