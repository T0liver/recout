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
  late WorkOut workOut;

  late TextEditingController nameController = TextEditingController(text: workOut.name);
  late TextEditingController yearController = TextEditingController(text: '${workOut.date.year}');
  late TextEditingController monthController = TextEditingController(text: workOut.date.month.toString().padLeft(2, '0'));
  late TextEditingController dayController = TextEditingController(text: workOut.date.day.toString().padLeft(2, '0'));
  late TextEditingController durationController = TextEditingController(text: (() {
    String wdur = workOut.duration.toString();
    if (wdur.contains('.')) {
      wdur = wdur.replaceAll(RegExp(r'0+$'), '');
      wdur = wdur.replaceAll(RegExp(r'\.$'), '');
    }
    return wdur;
  })(),);
  late String duration = workOut.durationUnit;
  late TextEditingController locationController = TextEditingController(text: workOut.location);

  @override
  void initState() {
    super.initState();
    workOut = widget.workout;
  }

  bool nameValid = true;
  bool yearValid = true;
  bool monthValid = true;
  bool dayValid = true;
  bool durationValid = true;

  void getWorkoutData() {
    final isYearValid = int.tryParse(yearController.text) != null;
    final isMonthValid = int.tryParse(monthController.text) != null;
    final isDayValid = int.tryParse(dayController.text) != null;
    final isDurationValid = double.tryParse(durationController.text) != null;
    final isNameValid = nameController.text != '';

    setState(() {
      yearValid = isYearValid;
      monthValid = isMonthValid;
      dayValid = isDayValid;
      durationValid = isDurationValid;
      nameValid = isNameValid;
    });

    if (isYearValid && isMonthValid && isDayValid && isDurationValid) {
      debugPrint('Edzés neve: ${nameController.text}');
      debugPrint('Időpont: ${yearController.text}.${monthController.text}.${dayController.text}.');
      debugPrint('Időtartam: ${durationController.text} $duration');
      debugPrint('Helyszín: ${locationController.text}');
      Navigator.pushNamed(context, '/');
    }
  }

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
              Spacer(flex: 1,),
              Heading(text: l10n.editactivity, fontSize: 24,),
              Spacer(flex: 2,),
              Image.asset(
                'assets/graphics/icons/icons8-strong-arm-128.png',
                height: MediaQuery.sizeOf(context).height * 0.15,
              ),
              const Spacer(flex: 2),
              BoxInputLabel(controller: nameController, placeholder: l10n.inputworkout, valid: nameValid,),
              const Spacer(flex: 1),
              BodyBase(l10n.dateofworkout),
              SizedBox(height: 10),
              Row(
                children: [
                  Spacer(),
                  NumberInputLabel(controller: yearController, placeholder: l10n.year, valid: yearValid,),
                  SizedBox(width: 10),
                  NumberInputLabel(controller: monthController, placeholder: l10n.month, valid: monthValid,),
                  SizedBox(width: 10),
                  NumberInputLabel(controller: dayController, placeholder: l10n.day, valid: dayValid,),
                  Spacer(),
                ],
              ),
              const Spacer(flex: 1),
              BodyBase(l10n.durationofworkout),
              const Spacer(flex: 1),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Spacer(),
                    NumberInputLabel(controller: durationController, width: 30, valid: durationValid,),
                    DurationChooser(duration: duration),
                    Spacer(),
                  ]
              ),
              const Spacer(flex: 1),
              BodyBase(l10n.locationofworkout),
              SizedBox(height: 10),
              BoxInputLabel(controller: locationController, placeholder: l10n.locationinput,),
              Spacer(flex: 1),
              TextIconBtn(text: l10n.save, icon: 'assets/graphics/icons/icons8-save-32.png', onPressed: () => getWorkoutData()),
              Spacer(flex: 2,)
            ],
          ),
        ),
      ),
    );
  }
}