import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:recout/auth_gate.dart';
import 'package:recout/user_state.dart';
import 'firebase_options.dart';

import 'package:recout/globals.dart';
import 'package:recout/l10n/l10n.dart';
import 'package:recout/workout.dart';

import 'package:recout/account.dart';
import 'package:recout/critique.dart';
import 'package:recout/edit_account.dart';
import 'package:recout/edit_activity.dart';
import 'package:recout/first_page.dart';
import 'package:recout/language.dart';
import 'package:recout/login_page.dart';
import 'package:recout/new_activity.dart';
import 'package:recout/open_activity.dart';
import 'package:recout/register_page.dart';
import 'package:recout/settings.dart';
import 'package:recout/theme.dart';

Future<void> main() async {
  GlobalMaterialLocalizations.delegate;
  Locale(Globals.language);

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserState())
      ],
    child: const RecOut(),
    )
  );
}

class RecOut extends StatelessWidget {
  const RecOut({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // the changes here will be just test for running and testing if the UI is working
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RecOut!',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
      ),
      localizationsDelegates: L10n.localizationsDelegates,
      supportedLocales: L10n.supportedLocales,
      initialRoute: '/',
      routes: {
        '/': (context) => const AuthGate(),
        '/critique': (context) => const CritiquePage(),
        '/first': (context) => const FirstPage(),
        '/languages': (context) => const LanguagePage(),
        '/login': (context) => const LoginPage(),
        '/new_activity': (context) => const NewActivityPage(),
        '/profile': (context) => const AccountPage(),
        '/profile/edit': (context) => const EditAccountPage(),
        '/register': (context) => const RegisterPage(),
        '/settings': (context) => const SettingsPage(),
        '/themes': (context) => const ThemePage(),
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


