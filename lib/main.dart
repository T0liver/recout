import 'package:flutter/material.dart';
import 'package:recout/button.dart';

void main() {
  runApp(const RecOut());
}

class RecOut extends StatelessWidget {
  const RecOut({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // the changes here will be just test for running and testing if the UI is working
    return MaterialApp(
      title: 'RecOut!',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
      ),
      home: Scaffold(
        body: Button(text: "Bejelentkezés", onPressed: () {},
        ),
      ),
    );
  }
}
