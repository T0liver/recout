import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";

import "package:recout/ui/legos/button.dart";
import "package:recout/l10n/l10n.dart";
import "package:recout/ui/legos/labels.dart";
import "package:recout/ui/legos/texts.dart";
import "package:recout/themes/app_colors.dart";

class PasswordResetPage extends StatefulWidget {
  const PasswordResetPage({super.key});

  @override
  State<PasswordResetPage> createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  final TextEditingController _emailcontroller = TextEditingController();

  bool _isLoading = false;

  Future<void> resetPassword() async {
    final l10n = L10n.of(context)!;

    setState(() {
      _isLoading = true;
    });

    final enteredEmail = _emailcontroller.text.trim();

    try {
      final userQuery = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: enteredEmail)
          .limit(1)
          .get();

      if (userQuery.docs.isNotEmpty) {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: enteredEmail);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.emailSent)),
          );
        }
      } else {
        throw FirebaseAuthException(code: 'user-not-found');
      }
    } on FirebaseAuthException catch (e) {
      String msg;
      switch (e.code) {
        case 'invalid-email':
          msg = l10n.invalidEmail;
          break;
        case 'missing-email':
          msg = l10n.missingEmail;
          break;
        case 'user-not-found':
          msg = l10n.emailNotFound;
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
        Heading(text: l10n.resetPassword),
        const Spacer(flex: 3),
        TextLabel(controller: _emailcontroller, hint: l10n.emailaddr),
        const Spacer(flex: 2),
        Button(
          bgColor: _isLoading ? context.tertiaryColor : context.primaryColor,
          text: _isLoading ? '...' : l10n.letsgoMail,
          onPressed: () {
            if (!_isLoading) {
              resetPassword();
            }
          },
        ),
        const Spacer(flex: 1),
      ],
    );
  }
}
