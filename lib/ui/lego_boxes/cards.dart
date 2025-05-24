import "dart:convert";

import "package:cached_network_image/cached_network_image.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:http/http.dart" as http;
import "package:intl/intl.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:recout/ui/legos/button.dart";
import "package:recout/l10n/l10n.dart";
import "package:recout/ui/legos/labels.dart";
import "package:recout/ui/legos/texts.dart";
import "package:recout/themes/app_colors.dart";
import "package:recout/data/models/workout.dart";

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
            color: context.cardBackgroundColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: context.secondaryColor),
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
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: context.textColor
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
                        color: context.secondaryColor,
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

  final DateTime today = DateTime.now();
  late TextEditingController yearController = TextEditingController(text: '${today.year}');
  late TextEditingController monthController = TextEditingController(text: DateFormat('MM').format(today));
  late TextEditingController dayController = TextEditingController(text: DateFormat('dd').format(today));

  final TextEditingController durationController = TextEditingController();
  final ValueNotifier<String> durationUnit = ValueNotifier<String>('perc');

  bool nameValid = true;
  bool yearValid = true;
  bool monthValid = true;
  bool dayValid = true;
  bool durationValid = true;

  void getWorkoutData() async {
    final isYearValid = int.tryParse(yearController.text) != null;
    final isMonthValid = int.tryParse(monthController.text) != null;
    final isDayValid = int.tryParse(dayController.text) != null;
    final isDurationValid = int.tryParse(durationController.text) != null;
    final isNameValid = nameController.text != '';
    final isDurationUnitValid = durationUnit.value != '';

    setState(() {
      yearValid = isYearValid;
      monthValid = isMonthValid;
      dayValid = isDayValid;
      durationValid = isDurationValid;
      nameValid = isNameValid;
    });

    if (isYearValid && isMonthValid && isDayValid && isDurationValid && isDurationUnitValid) {
      final DateTime date = DateTime(
        int.parse(yearController.text),
        int.parse(monthController.text),
        int.parse(dayController.text),
      );

      final workoutData = {
        'userid': FirebaseAuth.instance.currentUser?.uid,
        'name': nameController.text,
        'date': Timestamp.fromDate(date),
        'duration': double.parse(durationController.text),
        'durationUnit': durationUnit.value,
        'location': locationController.text,
        'createdAt': FieldValue.serverTimestamp(),
      };

      try {
        await FirebaseFirestore.instance.collection('workouts').add(workoutData);
        debugPrint('Workout mentve Firestore-ba: $workoutData');

        if (mounted) {
          (context.findAncestorStateOfType<_WorkoutRecCardState>() as _WorkoutRecCardState).toggleInputVisibility();
        }
      } catch (e) {
        debugPrint('Hiba a Firestore mentés során: $e');
      }
    }
  }

  void back() {
    (context.
    findAncestorStateOfType<_WorkoutRecCardState>()
    as _WorkoutRecCardState)
        .toggleInputVisibility();
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
            color: context.cardBackgroundColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: context.secondaryColor),
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
                    DurationChooser(duration: durationUnit),
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

              Row(
                children: [
                  Container(
                      alignment: Alignment(-0.9, 0.9),
                      child: SizedBox(
                        width: 32, height: 32,
                        child: IconButton(
                            onPressed: () => back(),
                            icon: Image.asset('assets/graphics/icons/icons8-back-32.png')
                        ),
                      )
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Button(
                      text: l10n.recworkout,
                      size: const Size(200, 50),
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: context.textColor,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      onPressed: () {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          getWorkoutData();
                        });
                      },
                    ),
                  ),
                ],
              )
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

class ListCard extends StatelessWidget {
  final WorkOut workOut;

  const ListCard(this.workOut, {super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width * 0.9 < 500
        ? MediaQuery.of(context).size.width * 0.9
        : 500;
    String wdur = workOut.duration.toString();
    if (wdur.contains('.')) {
      wdur = wdur.replaceAll(RegExp(r'0+$'), '');
      wdur = wdur.replaceAll(RegExp(r'\.$'), '');
    }
    return SizedBox(
      width: width,
      child: GestureDetector(
        onTap: () {
          context.push('/workout/${workOut.wid}');
        },
        child: Container(
          margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: context.cardBackgroundColor,
            border: Border.all(color: context.secondaryColor),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Image.asset(workOut.icon, width: 40, height: 40,),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BodyStrongText(workOut.name),
                    SizedBox(height: 4),
                    BodySmallText('$wdur ${workOut.durationUnit}'),
                    BodySmallText(workOut.location),
                    BodySmallText('${workOut.date.year}.${workOut.date.month.toString().padLeft(2, '0')}.${workOut.date.day.toString().padLeft(2, '0')}.'),
                  ],
                ),
              ),
              IconButton(
                icon: Image.asset('assets/graphics/icons/icons8-editing-32.png', width: 24, height: 24,),
                onPressed: () {
                  context.push('/workout/${workOut.wid}/edit');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AdCard extends StatefulWidget {
  const AdCard({super.key});

  @override
  State<StatefulWidget> createState() => _AdCardState();
}

class _AdCardState extends State<AdCard> {
  String? imageUrl;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchDogImage();
  }

  Future<void> fetchDogImage() async {
    final response = await http.get(Uri.parse('https://dog.ceo/api/breeds/image/random'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        imageUrl = data['message'];
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width * 0.9 < 500
        ? MediaQuery.of(context).size.width * 0.9
        : 500;

    return SizedBox(
      width: width,
      child: Container(
        margin: const EdgeInsets.all(12),
        child: Center(
          child: isLoading
              ? CircularProgressIndicator()
              : ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              alignment: Alignment.center,
              children: [
                CachedNetworkImage(
                  imageUrl: imageUrl!,
                  width: width,
                  height: 120,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: Colors.grey[300],
                    height: 100,
                    width: width,
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey,
                    height: 100,
                    width: width,
                    child: Icon(Icons.error),
                  ),
                ),
                Container(
                  height: 100,
                  width: width,
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Heading(
                      text: L10n.of(context)!.noad,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DialogueCard extends StatelessWidget {
  final String title;
  final String body;
  final double maxwidth;
  final String okText;
  final String okIcon;
  final String noText;
  final VoidCallback onYes;
  final VoidCallback onNo;

  const DialogueCard({
    super.key,
    required this.title,
    required this.body,
    required this.onYes,
    required this.onNo,
    this.maxwidth = 500,
    this.okText = 'Igen',
    this.noText = 'Nem',
    this.okIcon = 'assets/graphics/icons/icons8-trash-can-32.png',
  });

  @override
  Widget build(BuildContext context) {
    final double width =
    MediaQuery.of(context).size.width * 0.9 < 500
        ? MediaQuery.of(context).size.width * 0.9
        : 500;
    return ClipRect(
        child: SizedBox(width: width,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: context.cardBackgroundColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: context.secondaryColor),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Heading(text: title, fontSize: 18,),
                const SizedBox(height: 8,),
                BodySmallText(
                  body,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: context.textColor
                  ),
                ),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Spacer(),
                    TextIconBtn(
                        text: okText,
                        icon: okIcon,
                        textstyle: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: context.textColor
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 5),
                        size: Size(128, 50),
                        onPressed: onYes
                    ),
                    Spacer(),
                    Button(
                        text: noText,
                        style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: context.textColor
                        ),
                        bgColor: context.cardBackgroundColor,
                        border: BorderSide(color: context.tertiaryColor, width: 2),
                        padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 5),
                        size: Size(128, 50),
                        onPressed: onNo
                    ),
                    Spacer(),
                  ],
                )
              ],
            ),
          ),
        )
    );
  }
}