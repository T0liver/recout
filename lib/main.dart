import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:recout/button.dart';
import 'package:recout/texts.dart';

import 'package:recout/l10n/l10n.dart';

void main() {
  GlobalMaterialLocalizations.delegate;
  const Locale("hu");
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
      localizationsDelegates: L10n.localizationsDelegates,
      supportedLocales: L10n.supportedLocales,
      home: HomeTest(),
    );
  }
}

class HomeTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context)!;
    return Scaffold(
      body: Column(
          children: [
            Heading(text: l10n.firstGreet),
            SizedBox(height: 100,),
            LanguageLabel(),
            SizedBox(height: 200),
            Button(text: l10n.login, onPressed: () {},),
            SizedBox(height: 20,),
            Button(text: l10n.register, onPressed: () {},
              bgColor: Colors.white,
              border: BorderSide(color: const Color(0xFFF9DC5C), width: 2),
            )
          ]
      )
    );
  }

}
