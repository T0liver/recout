import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recout/ui/legos/labels.dart';
import 'package:recout/ui/legos/texts.dart';

import '../legos/button.dart';
import '../../l10n/l10n.dart';

class EditAccountPage extends StatefulWidget {
  const EditAccountPage({super.key});

  @override
  State<StatefulWidget> createState() => _EditAccountPageState();
}

class _EditAccountPageState extends State<EditAccountPage> {
  late TextEditingController nameController = TextEditingController();
  late TextEditingController yearController = TextEditingController();
  late TextEditingController monthController = TextEditingController();
  late TextEditingController dayController = TextEditingController();

  bool yearValid = true;
  bool monthValid = true;
  bool dayValid = true;

  String uname = '';
  String email = '';

  bool _isLoading = true;

  Future<void> loadUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if(user == null) return;

    final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    final data = doc.data();
    if (data == null) return;

    setState(() {
      uname = data['username'] ?? '';
      email = user.email ?? '';
      nameController.text = data['name'] ?? '';
      final Timestamp? dobTimestamp = data['dateOfBirth'];
      if (dobTimestamp != null) {
        final dob = dobTimestamp.toDate();
        yearController.text = dob.year.toString();
        monthController.text = dob.month.toString().padLeft(2, '0');
        dayController.text = dob.day.toString().padLeft(2, '0');
      }
      _isLoading = false;
    });
  }

  Future<void> saveUserData() async {
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

    if (!isYearValid || !isMonthValid || !isDayValid) return;

    final user = FirebaseAuth.instance.currentUser;
    if(user == null) return;

    final Map<String, dynamic> updatedData = {};

    if (nameController.text.isNotEmpty) {
      updatedData['name'] = nameController.text.trim();
    }
    if (!isYearEmpty && !isMonthEmpty && !isDayEmpty) {
      final dob = DateTime(
        int.parse(yearController.text),
        int.parse(monthController.text),
        int.parse(dayController.text),
      );
      updatedData['dateOfBirth'] = Timestamp.fromDate(dob);
    }
    if (updatedData.isNotEmpty) {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).update(updatedData);
    }

    if (mounted) {
      context.pop();
    }
  }

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    final l10n = L10n.of(context)!;
    final double width =
    MediaQuery.of(context).size.width * 0.9 < 700
        ? MediaQuery.of(context).size.width * 0.9
        : 700;

    String funame = uname.isEmpty ? l10n.username_s : uname;
    String femail = email.isEmpty ? l10n.email_s : email;

    return Center(
      child: SizedBox(
        width: width,
        child: Column(
          children: [
            Spacer(),
            const BackBtn(),
            Spacer(),
            TitleUndelineText(text: l10n.editdatas),
            Spacer(),
            Image.asset('assets/graphics/icons/icons8-test-account-128.png', height: 128,),
            SmallTitleUndelineText(text: funame, center: true,),
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
            SmallTitleUndelineText(text: femail, center: true,),
            Spacer(),
            Button(text: l10n.allright, onPressed: saveUserData),
            Spacer(),
          ],
        ),
      )
    );
  }
}