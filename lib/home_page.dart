import 'package:flutter/material.dart';
import 'package:recout/button.dart';
import 'package:recout/cards.dart';
import 'package:recout/globals.dart';
import 'package:recout/l10n/l10n.dart';
import 'package:recout/texts.dart';

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
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(width: 20,),
              Column(
                children: [
                  SizedBox(height: 30,),
                  HelloText(name: Globals.user!.username),
                ],
              ),
              Spacer(),
              SettingsBtn(),
              SizedBox(width: 20,),
            ],
          ),
          // Spacer(flex: 1,),
          SizedBox(height: 50,),
          WorkoutRecCard(),
          SizedBox(height: 20,),
          TitleUndelineText(text: L10n.of(context)!.prevworkouts),
          SizedBox(height: 2,),
          ListCard(name: 'Lábujjbirkózás', duration: '0,5 óra', date: '2025. 03. 16.', location: 'Budapest'),
        ],
      ),
    );
  }
}
