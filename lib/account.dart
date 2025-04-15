import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recout/cards.dart';
import 'package:recout/texts.dart';
import 'package:recout/user_state.dart';

import 'button.dart';
import 'l10n/l10n.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<StatefulWidget> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  bool _showDialogue = false;

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
        .where('email', isEqualTo: user?.email)
        .limit(1)
        .get();
    final userData = userQuery.docs.first.data();

    if(userData['name'] != null) {
      rname = userData['name'];
    }
    email = user!.email!;
    if(userData['dateOfBirth'] != null) {
      dobTmp = userData['dateOfBirth'];
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context)!;
    final double width =
    MediaQuery.of(context).size.width * 0.9 < 700
        ? MediaQuery.of(context).size.width * 0.9
        : 700;

    if (Provider.of<UserState>(context).username == null) {
      uname = l10n.username_s;
      rname = l10n.name_s;
      dob = l10n.dateofbirth_s;
      email = l10n.email_s;
    } else {
      uname = Provider.of<UserState>(context).username!;

      getUserData();

      if (rname == '') {
        rname = l10n.name_s;
      }
      if (dobTmp == null) {
        dob = l10n.dateofbirth_s;
      } else {
        dob = '${dobTmp?.year}.${dobTmp?.month}.${dobTmp?.day}.';
      }
    }

    return Scaffold(
      body: Stack(
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
                  Button(text: l10n.editdatas, onPressed: () {
                    debugPrint("Edit");
                    Navigator.pushNamed(context, '/profile/edit');
                  }),
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
                      onYes: () {
                        //TODO: törlés
                        Navigator.pushNamed(context, '/first');
                      },
                      onNo: _toggle,
                    ),
                  ),
                  Spacer()
                ],
              )
            )
          ]
        ],
      )
    );
  }
}