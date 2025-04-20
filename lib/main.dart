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
      onGenerateRoute: (route) {
        Widget page;
        switch (route.name) {
          case '/':
            page = const ScrollWrapper(AuthGate());
            break;
          case '/critique':
            page = const ScrollWrapper(CritiquePage());
            break;
          case '/first':
            page = const ScrollWrapper(FirstPage());
            break;
          case '/languages':
            page = const ScrollWrapper(LanguagePage());
            break;
          case '/login':
            page = const ScrollWrapper(LoginPage());
            break;
          case '/new_activity':
            page = const ScrollWrapper(NewActivityPage());
            break;
          case '/profile':
            page = const ScrollWrapper(AccountPage());
            break;
          case '/profile/edit':
            page = const ScrollWrapper(EditAccountPage());
            break;
          case '/register':
            page = const ScrollWrapper(RegisterPage());
            break;
          case '/settings':
            page = const ScrollWrapper(SettingsPage());
            break;
          case '/themes':
            page = const ScrollWrapper(ThemePage());
            break;
          case '/workout':
            final workOut = route.arguments as WorkOut;
            page = ScrollWrapper(OpenActivityPage(workOut));
            break;
          case '/workout/edit':
            final workOut = route.arguments as WorkOut;
            page = ScrollWrapper(EditActivityPage(workOut));
            break;
          default:
            return null;
        }

        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            final offsetAnimation = animation.drive(tween);

            return SlideTransition(position: offsetAnimation, child: child);
          },
        );
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
