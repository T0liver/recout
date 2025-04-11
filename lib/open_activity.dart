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

  void _toggle() {
    setState(() {
      _showDialogue = !_showDialogue;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context)!;
    final double width =
    MediaQuery.of(context).size.width * 0.9 < 700
        ? MediaQuery.of(context).size.width * 0.9
        : 700;
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: SizedBox(
              width: width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 10,),
                  const BackBtn(),
                  SizedBox(height: 20),
                  Image.asset(
                    'assets/graphics/icons/icons8-strong-arm-128.png',
                    height: MediaQuery.sizeOf(context).height * 0.15,
                  ),
                  Heading(text: workOut.name, fontSize: 24, fontWeight: FontWeight.w400,),
                  const Spacer(flex: 1),

                  SizedBox(height: 20),
                  BodyBase(l10n.dateofworkout),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Spacer(),
                      BodyStrongText('${workOut.date.year}.'),
                      SizedBox(width: 10),
                      BodyStrongText('${workOut.date.month}.'),
                      SizedBox(width: 10),
                      BodyStrongText('${workOut.date.day}.'),
                      Spacer(),
                    ],
                  ),
                  SizedBox(height: 20),
                  BodyBase(l10n.durationofworkout),
                  SizedBox(height: 10),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Spacer(),
                        BodyStrongText('${workOut.duration}'),
                        BodyStrongText(workOut.durationUnit),
                        Spacer(),
                      ]
                  ),
                  SizedBox(height: 20),
                  BodyBase(l10n.locationofworkout),
                  SizedBox(height: 10),
                  BodyStrongText(workOut.location),
                  Spacer(flex: 1),
                  Row(
                    children: [
                      Spacer(flex: 1),
                      IconBtn(icon: 'assets/graphics/icons/icons8-remove-32.png', onPressed: () {}),
                      Spacer(flex: 2),
                      IconBtn(icon: 'assets/graphics/icons/icons8-edit-32.png', onPressed: () {}),
                      Spacer(flex: 1),
                    ],
                  ),
                  Spacer(flex: 1,)
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
                          //törlés
                          setState(() {
                            _showDialogue = false;
                          });
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