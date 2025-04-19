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
      // debugShowCheckedModeBanner: false,
      title: 'RecOut!',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
      ),
      localizationsDelegates: L10n.localizationsDelegates,
      supportedLocales: L10n.supportedLocales,
      initialRoute: '/',
      routes: {
        '/': (context) => const ScrollWrapper(AuthGate()),
        '/critique': (context) => const ScrollWrapper(CritiquePage()),
        '/first': (context) => const ScrollWrapper(FirstPage()),
        '/languages': (context) => const ScrollWrapper(LanguagePage()),
        '/login': (context) => const ScrollWrapper(LoginPage()),
        '/new_activity': (context) => const ScrollWrapper(NewActivityPage()),
        '/profile': (context) => const ScrollWrapper(AccountPage()),
        '/profile/edit': (context) => const ScrollWrapper(EditAccountPage()),
        '/register': (context) => const ScrollWrapper(RegisterPage()),
        '/settings': (context) => const ScrollWrapper(SettingsPage()),
        '/themes': (context) => const ScrollWrapper(ThemePage()),
        '/workout': (context) {
        final workOut = ModalRoute.of(context)!.settings.arguments as WorkOut;
        return ScrollWrapper(OpenActivityPage(workOut));
        },
        '/workout/edit': (context) {
        final workOut = ModalRoute.of(context)!.settings.arguments as WorkOut;
        return ScrollWrapper(EditActivityPage(workOut));
        },
      }
    );
  }
}

class ScrollWrapper extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? bottomNavigationBar;
  final FloatingActionButton? floatingActionButton;

  const ScrollWrapper(
    this.body,
    {super.key,
    this.appBar,
    this.bottomNavigationBar,
    this.floatingActionButton,}
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(child: body),
            ),
          );
        },
      ),
    );
  }
}
