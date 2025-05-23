import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recout/ui/legos/texts.dart';
import 'package:recout/data/models/workout.dart';

import '../legos/button.dart';
import '../../l10n/l10n.dart';
import '../legos/labels.dart';

class EditActivityPage extends StatefulWidget {
  final WorkOut workout;
  const EditActivityPage(this.workout, {super.key});

  @override
  State<StatefulWidget> createState() => _EditActivityPageState();
}

class _EditActivityPageState extends State<EditActivityPage> {
  late WorkOut workOut;

  late TextEditingController nameController;
  late TextEditingController yearController;
  late TextEditingController monthController;
  late TextEditingController dayController;
  late TextEditingController durationController;
  final ValueNotifier<String> duration = ValueNotifier<String>('');
  late TextEditingController locationController;

  @override
  void initState() {
    super.initState();
    workOut = widget.workout;

    nameController = TextEditingController(text: workOut.name);
    yearController = TextEditingController(text: '${workOut.date.year}');
    monthController = TextEditingController(text: workOut.date.month.toString().padLeft(2, '0'));
    dayController = TextEditingController(text: workOut.date.day.toString().padLeft(2, '0'));
    durationController = TextEditingController(text: (() {
      String wdur = workOut.duration.toString();
      if (wdur.contains('.')) {
        wdur = wdur.replaceAll(RegExp(r'0+$'), '');
        wdur = wdur.replaceAll(RegExp(r'\.$'), '');
      }
      return wdur;
    })());
    locationController = TextEditingController(text: workOut.location);
    duration.value = workOut.durationUnit;
  }

  bool nameValid = true;
  bool yearValid = true;
  bool monthValid = true;
  bool dayValid = true;
  bool durationValid = true;

  void updateWorkoutData() async {
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

    if (isYearValid && isMonthValid && isDayValid && isDurationValid && isNameValid) {
      final updatedDate = DateTime(
        int.parse(yearController.text),
        int.parse(monthController.text),
        int.parse(dayController.text),
      );

      final workoutUpdate = {
        'name': nameController.text,
        'date': Timestamp.fromDate(updatedDate),
        'duration': double.parse(durationController.text),
        'durationUnit': duration.value,
        'location': locationController.text,
      };

      try {
        await FirebaseFirestore.instance
          .collection('workouts')
          .doc(workOut.wid)
          .update(workoutUpdate);

        debugPrint('Frissítve Firestore-ban: $workoutUpdate');
        if (mounted) {
          context.go('/');
        }
      } catch (e) {
        debugPrint('Hiba: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context)!;
    final double width =
    MediaQuery.of(context).size.width * 0.9 < 700 ? MediaQuery.of(context).size.width * 0.9 : 700;

    return Center(
      child: SizedBox(
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            const BackBtn(),
            const Spacer(flex: 1),
            Heading(text: l10n.editactivity, fontSize: 24),
            const Spacer(flex: 2),
            Image.asset(
              'assets/graphics/icons/icons8-strong-arm-128.png',
              height: MediaQuery.sizeOf(context).height * 0.15,
            ),
            const Spacer(flex: 2),
            BoxInputLabel(controller: nameController, placeholder: l10n.inputworkout, valid: nameValid),
            const Spacer(flex: 1),
            BodyBase(l10n.dateofworkout),
            const SizedBox(height: 10),
            Row(
              children: [
                const Spacer(),
                NumberInputLabel(controller: yearController, placeholder: l10n.year, valid: yearValid),
                const SizedBox(width: 10),
                NumberInputLabel(controller: monthController, placeholder: l10n.month, valid: monthValid),
                const SizedBox(width: 10),
                NumberInputLabel(controller: dayController, placeholder: l10n.day, valid: dayValid),
                const Spacer(),
              ],
            ),
            const Spacer(flex: 1),
            BodyBase(l10n.durationofworkout),
            const Spacer(flex: 1),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                NumberInputLabel(controller: durationController, width: 30, valid: durationValid),
                DurationChooser(duration: duration),
                const Spacer(),
              ],
            ),
            const Spacer(flex: 1),
            BodyBase(l10n.locationofworkout),
            const SizedBox(height: 10),
            BoxInputLabel(controller: locationController, placeholder: l10n.locationinput),
            const Spacer(flex: 1),
            TextIconBtn(
              text: l10n.save,
              icon: 'assets/graphics/icons/icons8-save-32.png',
              onPressed: () => updateWorkoutData(),
            ),
            const Spacer(flex: 2),
          ],
        ),
      )
    );
  }
}
