import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  late String username;
  late String uid;
  late String uemail;

  Future<void> getLoginData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      if (mounted) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushReplacementNamed(context, '/first');
        });
      }
      return;
    }

    final username = Provider.of<UserState>(context, listen: false).username;
    if (username != null) return;

    final userQuery = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: user.email)
        .limit(1)
        .get();

    if (userQuery.docs.isEmpty) {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/first');
      }
    } else {
      final userData = userQuery.docs.first.data();
      if (mounted) {
        Provider.of<UserState>(context, listen: false).setUsername(userData['username']);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getLoginData();
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
