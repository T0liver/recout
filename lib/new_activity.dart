import 'package:flutter/material.dart';
import 'package:recout/button.dart';
import 'package:recout/l10n/l10n.dart';
import 'package:recout/labels.dart';
import 'package:recout/texts.dart';
import 'package:recout/workout.dart';

class NewActivityPage extends StatefulWidget {
  const NewActivityPage({super.key});

  @override
  State<StatefulWidget> createState() => _NewActivityPageState();
}

class _NewActivityPageState extends State<NewActivityPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController monthController = TextEditingController();
  final TextEditingController dayController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  late String duration = '';
  final TextEditingController locationController = TextEditingController();

  WorkOut? workOut;

  bool nameValid = true;
  bool yearValid = true;
  bool monthValid = true;
  bool dayValid = true;
  bool durationValid = true;

  void getWorkoutData() {
    final isYearValid = int.tryParse(yearController.text) != null;
    final isMonthValid = int.tryParse(monthController.text) != null;
    final isDayValid = int.tryParse(dayController.text) != null;
    final isDurationValid = int.tryParse(durationController.text) != null;
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
              Heading(text: l10n.recordnewactivity, fontSize: 24,),
              SizedBox(height: 20),
              Image.asset(
                'assets/graphics/icons/icons8-strong-arm-128.png',
                height: MediaQuery.sizeOf(context).height * 0.15,
              ),
              const Spacer(flex: 1),
              BoxInputLabel(controller: nameController, placeholder: l10n.inputworkout, valid: nameValid,),
              SizedBox(height: 20),
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
              SizedBox(height: 20),
              BodyBase(l10n.durationofworkout),
              SizedBox(height: 10),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Spacer(),
                    NumberInputLabel(controller: durationController, width: 30, valid: durationValid,),
                    DurationChooser(duration: duration),
                    Spacer(),
                  ]
              ),
              SizedBox(height: 20),
              BodyBase(l10n.locationofworkout),
              SizedBox(height: 10),
              BoxInputLabel(controller: locationController, placeholder: l10n.locationinput,),
              Spacer(flex: 1),
              TextIconBtn(text: l10n.save, icon: 'assets/graphics/icons/icons8-save-32.png', onPressed: () => getWorkoutData()),
              Spacer(flex: 1,)
            ],
          ),
        ),
      ),
    );
  }
}