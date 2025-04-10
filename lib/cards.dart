import "package:flutter/material.dart";
import "package:recout/button.dart";
import "package:recout/l10n/l10n.dart";
import "package:recout/labels.dart";
import "package:recout/texts.dart";

class RecWorkoutCard extends StatelessWidget {

  const RecWorkoutCard({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context)!;
    final double width =
      MediaQuery.of(context).size.width * 0.9 < 500
      ? MediaQuery.of(context).size.width * 0.9
      : 500;
    return ClipRect(
      child: SizedBox(width: width,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Heading(text: l10n.homemsg, fontSize: 18,),
                    SizedBox(height: 12),
                    Row(
                        children: [
                          Button(
                            text: l10n.recworkout,
                            size: Size(width * 0.62, 50),
                            onPressed: () {
                              (context.
                              findAncestorStateOfType<_WorkoutRecCardState>()
                              as _WorkoutRecCardState)
                                  .toggleInputVisibility();
                            },
                            style: const TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: Colors.black
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          ),
                          const SizedBox(width: 16),
                          SizedBox(
                            width: 72,
                            height: 72,
                            child: Image.asset(
                              'assets/graphics/icons/icons8-strong-arm-128.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ]
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l10n.explworkout,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                        color: Color(0xFFB3B3B3),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}

class InputWorkoutCard extends StatefulWidget {
  const InputWorkoutCard({super.key});

  @override
  State<InputWorkoutCard> createState() => _InputWorkoutCardState();
}

class _InputWorkoutCardState extends State<InputWorkoutCard> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  final TextEditingController yearController = TextEditingController();
  final TextEditingController monthController = TextEditingController();
  final TextEditingController dayController = TextEditingController();

  final TextEditingController durationController = TextEditingController();
  String duration = '';

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
      (context.
      findAncestorStateOfType<_WorkoutRecCardState>()
      as _WorkoutRecCardState)
          .toggleInputVisibility();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context)!;
    final double width =
    MediaQuery.of(context).size.width * 0.9 < 500
        ? MediaQuery.of(context).size.width * 0.9
        : 500;
    return ClipRect(
      child: SizedBox(width: width,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BoxInputLabel(controller: nameController, placeholder: l10n.inputworkout, valid: nameValid,),
              const SizedBox(height: 10),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('${l10n.date}:', style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(width: 12),
                  NumberInputLabel(controller: yearController, placeholder: l10n.year, valid: yearValid,),
                  const SizedBox(width: 8),
                  NumberInputLabel(controller: monthController, placeholder: l10n.month, valid: monthValid,),
                  const SizedBox(width: 8),
                  NumberInputLabel(controller: dayController, placeholder: l10n.day, valid: dayValid,),
                  const Spacer(),
                ],
              ),
              const SizedBox(height: 10),

              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('${l10n.duration}:', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(width: 10),
                    NumberInputLabel(controller: durationController, width: 30, valid: durationValid,),
                    DurationChooser(duration: duration),
                  ]
              ),
              const SizedBox(height: 10,),
              Row(
                children: [
                  Text('${l10n.location}:', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(width: 12),
                  StringInputLabel(controller: locationController, placeholder: l10n.location_l,),
                ],
              ),

              const SizedBox(height: 16),

              Align(
                alignment: Alignment.centerRight,
                child: Button(
                  text: l10n.recworkout,
                  size: const Size(200, 40),
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  onPressed: () => getWorkoutData(),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}

class WorkoutRecCard extends StatefulWidget {
  const WorkoutRecCard({super.key});

  @override
  State<StatefulWidget> createState() => _WorkoutRecCardState();
}

class _WorkoutRecCardState extends State<WorkoutRecCard> {
  bool showInput = false;

  void toggleInputVisibility() {
    setState(() {
      showInput = !showInput;
    });
  }

  @override
  Widget build(BuildContext context) {
    return !showInput ? RecWorkoutCard() : InputWorkoutCard();
  }
}