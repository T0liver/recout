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
                            onPressed: () {},
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

  void getWorkoutData() {
    debugPrint('Edzés neve: ${nameController.text}');
    debugPrint('Időpont: ${yearController.text}.${monthController.text}.${dayController.text}.');
    debugPrint('Időtartam: ${durationController.text} $duration');
    debugPrint('Helyszín: ${locationController.text}');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context)!;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BoxInputLabel(controller: nameController, placeholder: l10n.inputworkout,),
          const SizedBox(height: 16),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Időpont:', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(width: 12),
              NumberInputLabel(controller: yearController, placeholder: "év",),
              const SizedBox(width: 8),
              NumberInputLabel(controller: monthController, placeholder: "hó",),
              const SizedBox(width: 8),
              NumberInputLabel(controller: dayController, placeholder: "nap",),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 8),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Időtartam:', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(width: 12),
              // DurationChooser(duration: duration),
            ]
          ),
          const SizedBox(width: 8),
          Row(
            children: [
              const Text('Helyszín:', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(width: 12),
              StringInputLabel(controller: locationController, placeholder: "Helyszín",),
            ],
          ),

          const SizedBox(height: 16),

          Align(
            alignment: Alignment.centerRight,
            child: Button(
              text: 'Edzés rögzítése',
              style: const TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Colors.black
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              onPressed: () => getWorkoutData(),
            ),
          ),
        ],
      ),
    );
  }
}