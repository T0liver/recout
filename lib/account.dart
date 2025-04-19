import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recout/cards.dart';
import 'package:recout/texts.dart';
import 'package:recout/user_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'button.dart';
import 'l10n/l10n.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<StatefulWidget> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  bool _showDialogue = false;
  bool _isLoading = true;

  late String uname = '', rname = '', dob, email = '';
  DateTime? dobTmp;

  void _toggle() {
    setState(() {
      _showDialogue = !_showDialogue;
    });
  }

  Future<void> getUserData() async {
    final user = FirebaseAuth.instance.currentUser;

    final userQuery = await FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .get();
    final userData = userQuery.data();

    if(userData?['name'] != null) {
      rname = userData?['name'];
    }
    if(userData?['email'] != null) {
      email = userData?['email'];
    }
    if(userData?['dateOfBirth'] != null) {
      dobTmp = userData?['dateOfBirth'];
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    final l10n = L10n.of(context)!;
    final double width =
    MediaQuery.of(context).size.width * 0.9 < 700
        ? MediaQuery.of(context).size.width * 0.9
        : 700;

    if (Provider.of<UserState>(context).username == null) {
      uname = l10n.username_s;
      email = l10n.email_s;
      rname = l10n.name_s;
      dob = l10n.dateofbirth_s;
    } else {
      uname = Provider.of<UserState>(context).username!;

      if (rname == '') {
        rname = l10n.name_s;
      }
      if (dobTmp == null) {
        dob = l10n.dateofbirth_s;
      } else {
        dob = '${dobTmp?.year}.${dobTmp?.month}.${dobTmp?.day}.';
      }
    }

    return Stack(
      children: [
        Center(
          child: SizedBox(
            width: width,
            child: Column(
              children: [
                Spacer(),
                const BackBtn(whereto: '/settings'),
                Spacer(),
                TitleUndelineText(text: l10n.useracc),
                Spacer(),
                Image.asset('assets/graphics/icons/icons8-test-account-128.png', height: 128,),
                SmallTitleUndelineText(text: uname, center: true,),
                Spacer(),
                SmallTitleUndelineText(text: rname, center: true,),
                Spacer(),
                SmallTitleUndelineText(text: dob, center: true,),
                Spacer(),
                SmallTitleUndelineText(text: email, center: true,),
                Spacer(),
                Button(text: l10n.editdatas, onPressed: () => Navigator.pushNamed(context, '/profile/edit')),
                Spacer(),
                Button(
                    text: l10n.deleteacc,
                    onPressed: _toggle,
                    bgColor: Colors.white,
                    border: const BorderSide(width: 2, color: Color(0xFFF9DC5C))
                ),
                Spacer(),
              ],
            ),
          ),
        ),
        if (_showDialogue) ...[
          Container(
            color: Colors.black12.withAlpha(50),
            child: Column(
              children: [
                Spacer(),
                Center(
                  child: DialogueCard(title: l10n.deleteTitle,
                    body: l10n.cantBeUndoneAccount,
                    onYes: () async {
                      try {
                        final user = FirebaseAuth.instance.currentUser;
                        if (user == null) return;
                        final uid = user.uid;

                        final workoutsQuery = await FirebaseFirestore.instance
                            .collection('workouts')
                            .where('userid', isEqualTo: uid)
                            .get();
                        for (var doc in workoutsQuery.docs) {
                          await doc.reference.delete();
                        }

                        await FirebaseFirestore.instance.collection('users').doc(uid).delete();
                        await user.delete();

                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setBool('isLoggedIn', false);

                        if (mounted && context.mounted) {
                          Navigator.pushNamedAndRemoveUntil(context, '/first', (route) => false);
                        }
                      } catch (e) {
                        debugPrint('Hiba: $e');
                        if (mounted && context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('${L10n.of(context)!.deleteError}: $e')),
                          );
                        }
                      }
                    },
                    onNo: _toggle,
                  ),
                ),
                Spacer()
              ],
            )
          )
        ]
      ]
    );
  }
}