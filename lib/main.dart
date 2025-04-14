import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:recout/account.dart';
import 'package:recout/critique.dart';
import 'package:recout/edit_account.dart';
import 'package:recout/edit_activity.dart';
import 'package:recout/globals.dart';
import 'package:recout/home_page.dart';

import 'package:recout/l10n/l10n.dart';
import 'package:recout/first_page.dart';
import 'package:recout/language.dart';
import 'package:recout/login_page.dart';
import 'package:recout/new_activity.dart';
import 'package:recout/open_activity.dart';
import 'package:recout/register_page.dart';
import 'package:recout/settings.dart';
import 'package:recout/theme.dart';
import 'package:recout/workout.dart';

void main() {
  GlobalMaterialLocalizations.delegate;
  Locale(Globals.language);
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
      initialRoute: '/profile/edit',
      routes: {
        '/': (context) => const HomePage(),
        '/first': (context) => const FirstPage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/new_activity': (context) => const NewActivityPage(),
        '/settings': (context) => const SettingsPage(),
        '/languages': (context) => const LanguagePage(),
        '/themes': (context) => const ThemePage(),
        '/critique': (context) => const CritiquePage(),
        '/profile': (context) => const AccountPage(),
        '/profile/edit': (context) => const EditAccountPage(),
        '/workout': (context) {
          final workOut = ModalRoute.of(context)!.settings.arguments as WorkOut;
          return OpenActivityPage(workOut);
        },
        '/workout/edit': (context) {
          final workOut = ModalRoute.of(context)!.settings.arguments as WorkOut;
          return EditActivityPage(workOut);
        },
      }
    );
  }
}


