import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'package:recout/l10n/language_provider.dart';
import 'package:recout/data/states/theme_provider.dart';
import 'package:recout/data/states/user_state.dart';
import 'package:recout/ui/pages/home_page.dart';
import 'data/firebase_options.dart';

import 'package:recout/data/globals.dart';
import 'package:recout/l10n/l10n.dart';
import 'package:recout/data/models/workout.dart';

import 'package:recout/ui/pages/account.dart';
import 'package:recout/ui/pages/critique.dart';
import 'package:recout/ui/pages/edit_account.dart';
import 'package:recout/ui/pages/edit_activity.dart';
import 'package:recout/ui/pages/first_page.dart';
import 'package:recout/ui/pages/language.dart';
import 'package:recout/ui/pages/login_page.dart';
import 'package:recout/ui/pages/open_activity.dart';
import 'package:recout/ui/pages/register_page.dart';
import 'package:recout/ui/pages/settings.dart';
import 'package:recout/ui/pages/theme.dart';

Future<void> main() async {
  GlobalMaterialLocalizations.delegate;
  Locale(Globals.language);

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

  if (kIsWeb) {
    usePathUrlStrategy();
    GoRouter.optionURLReflectsImperativeAPIs = true;
  }

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserState()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider())
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
    final locale = Provider.of<LanguageProvider>(context).locale;
    final theme = Provider.of<ThemeProvider>(context).currentTheme;

    final GoRouter router = GoRouter(
      initialLocation: '/',
      redirect: (BuildContext context, GoRouterState state) {
        bool goNoGo = FirebaseAuth.instance.currentUser == null;
        goNoGo = goNoGo && state.fullPath != '/login';
        goNoGo = goNoGo && state.fullPath != '/first';
        goNoGo = goNoGo && state.fullPath != '/register';
        goNoGo = goNoGo && state.fullPath != '/languages';
        if (goNoGo) {
          return '/first';
        } else {
          return null;
        }
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const ScrollWrapper(HomePage()),
        ),
        GoRoute(
          path: '/critique',
          builder: (context, state) => const ScrollWrapper(CritiquePage()),
        ),
        GoRoute(
          path: '/first',
          builder: (context, state) => const ScrollWrapper(FirstPage()),
        ),
        GoRoute(
          path: '/languages',
          builder: (context, state) => const ScrollWrapper(LanguagePage()),
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => const ScrollWrapper(LoginPage()),
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ScrollWrapper(AccountPage()),
          routes: [
            GoRoute(
              path: 'edit',
              builder: (context, state) => const ScrollWrapper(EditAccountPage()),
            ),
          ]
        ),
        GoRoute(
          path: '/register',
          builder: (context, state) => const ScrollWrapper(RegisterPage()),
        ),
        GoRoute(
          path: '/settings',
          builder: (context, state) => const ScrollWrapper(SettingsPage()),
        ),
        GoRoute(
          path: '/themes',
          builder: (context, state) => const ScrollWrapper(ThemePage()),
        ),
        GoRoute(
          path: '/workout/:id',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return FutureBuilder<WorkOut?>(
              future: OpenActivityPage.fromId(id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data == null) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(L10n.of(context)!.workoutNotFound)),
                    );
                    context.go('/');
                  });
                  return const SizedBox.shrink();
                }

                return ScrollWrapper(OpenActivityPage(snapshot.data!));
              },
            );
          },
          routes: [
            GoRoute(
              path: 'edit',
              builder: (context, state) {
                final id = state.pathParameters['id']!;
                return FutureBuilder<WorkOut?>(
                  future: OpenActivityPage.fromId(id),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (!snapshot.hasData || snapshot.data == null) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(L10n.of(context)!.workoutNotFound)),
                        );
                        context.go('/');
                      });
                      return const SizedBox.shrink();
                    }

                    return ScrollWrapper(EditActivityPage(snapshot.data!));
                  },
                );
              },
            ),
          ]
        ),
      ],
    );

    // the changes here will be just test for running and testing if the UI is working
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      title: 'RecOut!',
      theme: theme,
      locale: locale,
      localizationsDelegates: L10n.localizationsDelegates,
      supportedLocales: L10n.supportedLocales,
      localeResolutionCallback: (deviceLoc, supportedLocs) {
        if (locale != null) return locale;
        for (var l in supportedLocs) {
          if (l.languageCode == deviceLoc?.languageCode) {
            return l;
          }
        }
        return supportedLocs.first;
      },
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