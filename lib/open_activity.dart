import 'package:flutter/material.dart';
import 'package:recout/texts.dart';
import 'package:recout/workout.dart';

import 'button.dart';
import 'l10n/l10n.dart';

class OpenActivity extends StatelessWidget {
  final WorkOut workOut;

  const OpenActivity(this.workOut, {super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context)!;
    final double width =
    MediaQuery.of(context).size.width * 0.9 < 700
        ? MediaQuery.of(context).size.width * 0.9
        : 700;
    return Scaffold(
      body: Center(
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
              TextIconBtn(text: l10n.save, icon: 'assets/graphics/icons/icons8-save-32.png', onPressed: () {}),
              Spacer(flex: 1,)
            ],
          ),
        ),
      ),
    );
  }
}