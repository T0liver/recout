import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recout/button.dart';
import 'package:recout/cards.dart';
import 'package:recout/globals.dart';
import 'package:recout/l10n/l10n.dart';
import 'package:recout/texts.dart';
import 'package:recout/user.dart';
import 'package:recout/workout.dart';

class HomePage extends StatefulWidget {

  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late String username;
  late String uid;
  late String uemail;

  Future<void> getLoginData() async {
    final user = FirebaseAuth.instance.currentUser;

    final userQuery = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: user?.email)
        .limit(1)
        .get();

    if (userQuery.docs.isEmpty || user == null) {
      Navigator.pushNamed(context, '/first');
    }

    final userData = userQuery.docs.first.data();
    Globals.user = UserR(username: userData['username'], email: userData['email'], userid: user!.uid);
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, '/first');
      });
      return SizedBox.shrink();
    }

    getLoginData();

    final String uname;
    if (Globals.user?.username == null) {
      uname = 'kondi_geza52';
    } else {
      uname = Globals.user!.username;
      Globals.login();
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
