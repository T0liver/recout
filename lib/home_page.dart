import 'package:flutter/material.dart';
import 'package:recout/globals.dart';
import 'package:recout/l10n/l10n.dart';

class HomePage extends StatelessWidget {

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Globals.loggedin()) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, '/first');
      });
      return SizedBox.shrink();
    }
    final l10n = L10n.of(context);
    return Scaffold(
      body: Column(
        children: [

        ],
      ),
    );
  }
}
