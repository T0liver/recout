import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recout/texts.dart';
import 'package:recout/user_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'button.dart';
import 'l10n/l10n.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context)!;
    final double width =
    MediaQuery.of(context).size.width * 0.9 < 700
        ? MediaQuery.of(context).size.width * 0.9
        : 700;
    return Center(
      child: SizedBox(
        width: width,
        child: Column(
          children: [
            const SizedBox(height: 10,),
            const BackBtn(whereto: '/'),
            SizedBox(height: 20),
            TitleUndelineText(text: l10n.settings),
            const SizedBox(height: 20,),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, '/languages'),
              child: SmallTitleUndelineText(text: l10n.language),
            ),
            const SizedBox(height: 10,),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, '/themes'),
              child: SmallTitleUndelineText(text: l10n.changetheme),
            ),
            const SizedBox(height: 10,),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, '/profile'),
              child: SmallTitleUndelineText(text: l10n.useracc),
            ),
            const SizedBox(height: 10,),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, '/critique'),
              child: SmallTitleUndelineText(text: l10n.reporterror),
            ),
            const SizedBox(height: 10,),
            TextButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();

                final prefs = await SharedPreferences.getInstance();
                await prefs.setBool('isLoggedIn', false);

                if (context.mounted) {
                  Provider.of<UserState>(context, listen: false).clear();
                  Navigator.pushNamedAndRemoveUntil(context, '/first', (route) => false);
                }
            },
              child: SmallTitleUndelineText(text: l10n.logout),
            ),
            Spacer(flex: 6,),
            BodySmallText(l10n.impressum),
            Spacer(flex: 1,),
          ],
        ),
      ),
    );
  }
}