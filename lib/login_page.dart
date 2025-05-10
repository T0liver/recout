import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:provider/provider.dart";

import "package:recout/button.dart";
import "package:recout/l10n/l10n.dart";
import "package:recout/labels.dart";
import "package:recout/texts.dart";
import "package:recout/themes/app_colors.dart";
import "package:recout/user_state.dart";

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _unamecontroller = TextEditingController();
  final TextEditingController _passcontroller = TextEditingController();

  bool _isLoading = false;

  Future<void> loginWithUsernameAndPassword() async {
    final l10n = L10n.of(context)!;

    setState(() {
      _isLoading = true;
    });

    final enteredUsername = _unamecontroller.text.trim();
    final enteredPassword = _passcontroller.text.trim();

    try {
      final userQuery = await FirebaseFirestore.instance
          .collection('users')
          .where('username', isEqualTo: enteredUsername)
          .limit(1)
          .get();

      if (userQuery.docs.isEmpty) {
        throw FirebaseAuthException(code: 'user-not-found');
      }
      final userData = userQuery.docs.first.data();
      final email = userData['email'];
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: enteredPassword,
      );

      if (mounted) {
        Provider.of<UserState>(context, listen: false).setUsername(userData['username']);
        Navigator.pushReplacementNamed(context, '/');
      }
    } on FirebaseAuthException catch (e) {
      String msg;
      switch (e.code) {
        case 'user-not-found':
          msg = l10n.userNotFound;
          break;
        case 'wrong-password':
          msg = l10n.wrongPassword;
          break;
        case 'invalid-email':
          msg = l10n.invalidEmailLogin;
          break;
        default:
          msg = '${l10n.errorOccurred}: ${e.message}';
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
        const SizedBox(height: 10),
        const BackBtn(),
        const Spacer(flex: 2),
        Image.asset(
          'assets/graphics/icons/icons8-strong-arm-128.png',
          height: MediaQuery.sizeOf(context).height * 0.15,
        ),
        Heading(text: l10n.login),
        const Spacer(flex: 3),
        TextLabel(controller: _unamecontroller, hint: l10n.username),
        const SizedBox(height: 20),
        PasswordLabel(controller: _passcontroller, hint: l10n.password),
        const Spacer(flex: 2),
        Button(
          bgColor: _isLoading ? context.tertiaryColor : context.primaryColor,
          text: _isLoading ? '...' : l10n.letsgo,
          onPressed: () {
            if (!_isLoading) {
              loginWithUsernameAndPassword();
            }
          },
        ),
        const Spacer(flex: 1),
      ],
    );
  }
}
