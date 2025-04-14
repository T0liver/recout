import 'package:flutter/material.dart';
import 'package:recout/globals.dart';
import 'package:recout/labels.dart';
import 'package:recout/texts.dart';

import 'button.dart';
import 'l10n/l10n.dart';

class EditAccountPage extends StatefulWidget {
  const EditAccountPage({super.key});

  @override
  State<StatefulWidget> createState() => _EditAccountPageState();
}

class _EditAccountPageState extends State<EditAccountPage> {
  late TextEditingController nameController = TextEditingController(text: Globals.user?.name);
  late TextEditingController yearController = TextEditingController(text:
    Globals.user?.dateofbirth.year != null
    ? Globals.user?.dateofbirth.year.toString()
    : '');
  late TextEditingController monthController = TextEditingController(text: Globals.user?.dateofbirth.month.toString().padLeft(2, '0'));
  late TextEditingController dayController = TextEditingController(text: Globals.user?.dateofbirth.day.toString().padLeft(2, '0'));

  bool yearValid = true;
  bool monthValid = true;
  bool dayValid = true;

  void getUserData() {
    final isYearEmpty = yearController.text.isEmpty;
    final isMonthEmpty = monthController.text.isEmpty;
    final isDayEmpty = dayController.text.isEmpty;
    final isYearValid = isYearEmpty || int.tryParse(yearController.text) != null;
    final isMonthValid = isMonthEmpty || int.tryParse(monthController.text) != null;
    final isDayValid = isDayEmpty || int.tryParse(dayController.text) != null;

    setState(() {
      yearValid = isYearValid;
      monthValid = isMonthValid;
      dayValid = isDayValid;
    });

    if (isYearValid && isMonthValid && isDayValid) {
      if(nameController.text.isNotEmpty) {
        debugPrint("Név: ${nameController.text}");
      }
      if (!isYearEmpty && !isMonthEmpty && !isDayEmpty) {
        DateTime dob = DateTime(int.parse(yearController.text), int.parse(monthController.text), int.parse(dayController.text));
        debugPrint("Szül.idő: ${dob.toString()}");
      }
      Navigator.pushNamed(context, '/profile');
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context)!;
    final double width =
    MediaQuery.of(context).size.width * 0.9 < 700
        ? MediaQuery.of(context).size.width * 0.9
        : 700;

    String uname, email;
    if (Globals.user == null) {
      uname = l10n.username_s;
      email = l10n.email_s;
    } else {
      uname = Globals.user!.username;
      email = Globals.user!.email;
    }

    return Scaffold(
      body: Center(
        child: SizedBox(
          width: width,
          child: Column(
            children: [
              Spacer(),
              const BackBtn(),
              Spacer(),
              TitleUndelineText(text: l10n.useracc),
              Spacer(),
              Image.asset('assets/graphics/icons/icons8-test-account-128.png', height: 128,),
              SmallTitleUndelineText(text: uname, center: true,),
              Spacer(),
              SmallTitleUndelineInputLabel(controller: nameController, placeholder: l10n.name_s, center: true,),
              Spacer(),
              Row(
                children: [
                  Spacer(),
                  NumberInputLabel(controller: yearController, placeholder: l10n.year, fontSize: 24, width: 80,),
                  SizedBox(width: 10),
                  NumberInputLabel(controller: monthController, placeholder: l10n.month, fontSize: 24),
                  SizedBox(width: 10),
                  NumberInputLabel(controller: dayController, placeholder: l10n.day, fontSize: 24),
                  Spacer(),
                ],
              ),
              Spacer(),
              SmallTitleUndelineText(text: email, center: true,),
              Spacer(),
              Button(text: l10n.allright, onPressed: () => getUserData()),
              Spacer(),
            ],
          ),
        ),
      )
    );
  }
}