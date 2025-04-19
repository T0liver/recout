import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recout/texts.dart';
import 'package:recout/workout.dart';

import 'button.dart';
import 'cards.dart';
import 'l10n/l10n.dart';

class OpenActivityPage extends StatefulWidget {
  final WorkOut workOut;

  const OpenActivityPage(this.workOut, {super.key});

  @override
  State<StatefulWidget> createState() => _OpenActivityPageState();
}

class _OpenActivityPageState extends State<OpenActivityPage> {
  late final WorkOut workOut;

  bool _showDialogue = false;

  @override
  void initState() {
    super.initState();
    workOut = widget.workOut;
  }

  void _toggle() {
    setState(() {
      _showDialogue = !_showDialogue;
    });
  }

  Future<void> deleteWorkout() async {
    try {
      await FirebaseFirestore.instance.collection('workouts').doc(workOut.wid).delete();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(L10n.of(context)!.sucessfullDelete)),
        );
      }
    } catch(e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${L10n.of(context)!.errorOccurred}: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context)!;
    final double width =
    MediaQuery.of(context).size.width * 0.9 < 700
        ? MediaQuery.of(context).size.width * 0.9
        : 700;
    String wname, wdatey, wdatem, wdated, wdur, wduru, wloc;
    if(workOut.name == "") {
      wname = '_';
      wdatey = '_';
      wdatem = '_';
      wdated = '_';
      wdur = '_';
      wduru = '_';
      wloc = '_';
    } else {
      wname = workOut.name;
      wdatey = '${workOut.date.year}.';
      wdatem = '${workOut.date.month.toString().padLeft(2, '0')}.';
      wdated = '${workOut.date.day.toString().padLeft(2, '0')}.';
      wdur = workOut.duration.toString();
      if (wdur.contains('.')) {
        wdur = wdur.replaceAll(RegExp(r'0+$'), '');
        wdur = wdur.replaceAll(RegExp(r'\.$'), '');
      }
      wduru = workOut.durationUnit;
      wloc = workOut.location;
    }
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: SizedBox(
              width: width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20,),
                  const BackBtn(),
                  Spacer(flex: 1),
                  Image.asset(
                    'assets/graphics/icons/icons8-strong-arm-128.png',
                    height: MediaQuery.sizeOf(context).height * 0.15,
                  ),
                  Spacer(flex: 1),
                  Heading(text: wname, fontSize: 32, fontWeight: FontWeight.w600,),
                  const Spacer(flex: 1),

                  SizedBox(height: 20),
                  BodyBase(l10n.dateofworkout),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Spacer(),
                      BodyStrongText(wdatey),
                      SizedBox(width: 10),
                      BodyStrongText(wdatem),
                      SizedBox(width: 10),
                      BodyStrongText(wdated),
                      Spacer(),
                    ],
                  ),
                  Spacer(flex: 1),
                  SizedBox(height: 20),
                  BodyBase(l10n.durationofworkout),
                  SizedBox(height: 10),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Spacer(),
                        BodyStrongText('$wdur $wduru'),
                        Spacer(),
                      ]
                  ),
                  Spacer(flex: 1),
                  SizedBox(height: 20),
                  BodyBase(l10n.locationofworkout),
                  SizedBox(height: 10),
                  BodyStrongText(wloc),
                  Spacer(flex: 2),
                  Row(
                    children: [
                      Spacer(flex: 1),
                      IconBtn(icon: 'assets/graphics/icons/icons8-remove-32.png', onPressed: () => _toggle()),
                      Spacer(flex: 2),
                      IconBtn(icon: 'assets/graphics/icons/icons8-edit-32.png',
                          onPressed: () => Navigator.pushNamed(context, '/workout/edit', arguments: workOut)),
                      Spacer(flex: 1),
                    ],
                  ),
                  Spacer(flex: 2,)
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
                        body: l10n.cantBeUndone,
                        onYes: () {
                          deleteWorkout();
                          Navigator.pushNamed(context, '/');
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