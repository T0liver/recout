import 'package:flutter/material.dart';
import 'package:recout/button.dart';
import 'package:recout/cards.dart';
import 'package:recout/globals.dart';
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
                  HelloText(name: Globals.username),
                ],
              ),
              Spacer(),
              SettingsBtn(),
              SizedBox(width: 20,),
            ],
          ),
          // Spacer(flex: 1,),
          SizedBox(height: 50,),
          RecWorkoutCard(),
        ],
      ),
    );
  }
}
