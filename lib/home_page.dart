import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recout/button.dart';
import 'package:recout/cards.dart';
import 'package:recout/l10n/l10n.dart';
import 'package:recout/texts.dart';
import 'package:recout/user_state.dart';
import 'package:recout/workout.dart';

class HomePage extends StatefulWidget {

  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final uname = Provider.of<UserState>(context).username ?? L10n.of(context)!.username_s;

    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const SizedBox(width: 20,),
              Column(
                children: [
                  const SizedBox(height: 30,),
                  HelloText(name: uname),
                ],
              ),
              const Spacer(),
              SettingsBtn(),
              const SizedBox(width: 20,),
            ],
          ),
          // Spacer(flex: 1,),
          const SizedBox(height: 50,),
          WorkoutRecCard(),
          const SizedBox(height: 20,),
          TitleUndelineText(text: L10n.of(context)!.prevworkouts),
          const SizedBox(height: 2,),
          ListCard(WorkOut(name: 'Birkózás', date: DateTime(2025, 03, 18), duration: 30, durationUnit: 'perc', location: 'Balaton')),
        ],
      ),
    );
  }
}
