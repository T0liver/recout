import "package:flutter/material.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:go_router/go_router.dart";
import "package:provider/provider.dart";

import "package:recout/l10n/l10n.dart";

import "package:recout/ui/legos/button.dart";
import "package:recout/ui/legos/labels.dart";
import "package:recout/ui/legos/texts.dart";
import "package:recout/themes/app_colors.dart";
import "package:recout/data/states/user_state.dart";

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
      final userIsIn = await FirebaseFirestore.instance
        .collection('users')
        .where('username', isEqualTo: _unamecontroller.text.trim())
        .get();
      
      if (userIsIn.docs.isNotEmpty) {
        throw FirebaseAuthException(code: 'username-already-in-use');
      }
      
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

      await credential.user?.sendEmailVerification();

      if (mounted) {
        Provider.of<UserState>(context, listen: false).setUsername(_unamecontroller.text.trim());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.verifyEmail)),
        );
        context.go('/login');
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
        case 'username-already-in-use':
          msg = 'A felhasználónév már foglalt.';
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
    return Column(
      children: [
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
          bgColor: _isLoading ? context.tertiaryColor : context.primaryColor,
        ),
        const Spacer(flex: 1,)
      ]
    );
  }
}