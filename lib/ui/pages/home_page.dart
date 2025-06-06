import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:recout/ui/legos/button.dart';
import 'package:recout/ui/lego_boxes/cards.dart';
import 'package:recout/l10n/l10n.dart';
import 'package:recout/ui/legos/texts.dart';
import 'package:recout/data/states/user_state.dart';
import 'package:recout/data/models/workout.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {

  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final userId = FirebaseAuth.instance.currentUser?.uid;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _syncUserData(BuildContext context, User user) async {
    final prefs = await SharedPreferences.getInstance();
    if (context.mounted) {
      final uname = Provider.of<UserState>(context, listen: false).username;
      if (uname != null) return;
    }

    final query = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    final cuser = FirebaseAuth.instance.currentUser;
    if (cuser != null && !cuser.emailVerified) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', false);

      await FirebaseAuth.instance.signOut();
      if (context.mounted) {
        Provider.of<UserState>(context, listen: false).clear();
        context.go('/first');
      }
    }

    if (query.exists) {
      final data = query.data();
      if (data != null && data['username'] != null) {
        if (context.mounted) {
          Provider.of<UserState>(context, listen: false).setUsername(data['username']);
        }
        await prefs.setBool('isLoggedIn', true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _syncUserData(context, FirebaseAuth.instance.currentUser as User);

    final uname = Provider.of<UserState>(context).username ?? L10n.of(context)!.username_s;

    final double width = MediaQuery.of(context).size.width * 0.9 < 500
        ? MediaQuery.of(context).size.width * 0.9
        : 500;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
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

              SizedBox(
                width: width,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('workouts')
                      .where('userid', isEqualTo: userId)
                      .orderBy('date', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }

                    if (!snapshot.hasData ||snapshot.data!.docs.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.all(16),
                        child: BodyBase(L10n.of(context)!.noListElement),
                      );
                    }

                    final workouts = snapshot.data!.docs.map((doc){
                      final data = doc.data() as Map<String, dynamic>;
                      return WorkOut(
                        wid: doc.id,
                        name: data['name'] ?? '',
                        date: (data['date'] as Timestamp).toDate(),
                        duration: data['duration'] == null ? 0.0 : data['duration'].toDouble(),
                        durationUnit: data['durationUnit'] ?? '',
                        location: data['location'] ?? ''
                      );
                    }).toList();

                    final List<Widget> cardList = [];
                    final random = DateTime.now().millisecondsSinceEpoch % 6 + 5;

                    if (workouts.length >= 10) {
                      for (int i = 0; i < workouts.length; i++) {
                        if (i != 0 && i % random == 0) {
                          cardList.add(const AdCard());
                        }
                        cardList.add(ListCard(workouts[i]));
                      }
                    } else {
                      for (int i = 0; i < workouts.length; i++) {
                        cardList.add(ListCard(workouts[i]));
                      }
                      cardList.add(const AdCard());
                    }

                    return ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: cardList,
                    );
                  }
                )
              ),
            ],
          )
        )
      )
    );
  }
}
