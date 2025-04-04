import 'package:flutter/material.dart';

void main() {
  runApp(const RecOut());
}

class RecOut extends StatelessWidget {
  const RecOut({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RecOut!',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
      ),
    );
  }
}
