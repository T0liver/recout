import 'package:flutter/material.dart';
import 'package:recout/texts.dart';
import 'package:recout/workout.dart';

import 'button.dart';
import 'l10n/l10n.dart';
import 'labels.dart';

class EditActivityPage extends StatefulWidget {
  final WorkOut workout;
  const EditActivityPage(this.workout, {super.key});

  @override
  State<StatefulWidget> createState() => _EditActivityPageState();
}

class _EditActivityPageState extends State<EditActivityPage> {

  final TextEditingController nameController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController monthController = TextEditingController();
  final TextEditingController dayController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  late String duration = '';
  final TextEditingController locationController = TextEditingController();

  WorkOut workOut;

  _EditActivityPageState(this.workOut);

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
              Heading(text: l10n.recordnewactivity, fontSize: 24,),
              SizedBox(height: 20),
              Image.asset(
                'assets/graphics/icons/icons8-strong-arm-128.png',
                height: MediaQuery.sizeOf(context).height * 0.15,
              ),
              const Spacer(flex: 1),
              BoxInputLabel(controller: nameController, placeholder: l10n.inputworkout,),
              SizedBox(height: 20),
              BodyBase(l10n.dateofworkout),
              SizedBox(height: 10),
              Row(
                children: [
                  Spacer(),
                  NumberInputLabel(controller: yearController, placeholder: l10n.year),
                  SizedBox(width: 10),
                  NumberInputLabel(controller: monthController, placeholder: l10n.month),
                  SizedBox(width: 10),
                  NumberInputLabel(controller: dayController, placeholder: l10n.day),
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
                    NumberInputLabel(controller: durationController, width: 30),
                    DurationChooser(duration: duration),
                    Spacer(),
                  ]
              ),
              SizedBox(height: 20),
              BodyBase(l10n.locationofworkout),
              SizedBox(height: 10),
              BoxInputLabel(controller: locationController, placeholder: l10n.locationinput,),
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