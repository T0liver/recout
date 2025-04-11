import 'package:flutter/material.dart';
import 'package:recout/button.dart';
import 'package:recout/cards.dart';
import 'package:recout/globals.dart';
import 'package:recout/l10n/l10n.dart';
import 'package:recout/texts.dart';
import 'package:recout/workout.dart';

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
    final String uname;
    if (Globals.user?.username == null) {
      uname = 'kondi_geza52';
    } else {
      uname = Globals.user!.username;
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
                  HelloText(name: uname),
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
          ListCard(WorkOut(name: 'Birkózás', date: DateTime(2025, 03, 18), duration: 30, durationUnit: 'perc', location: 'Balaton')),
        ],
      ),
    );
  }
}
