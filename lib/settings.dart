import 'package:flutter/material.dart';
import 'package:recout/texts.dart';

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
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: width,
          child: Column(
            children: [
              const SizedBox(height: 10,),
              const BackBtn(),
              SizedBox(height: 20),
              TitleUndelineText(text: l10n.settings),
              const SizedBox(height: 20,),
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/languages'),
                child: SmallTitleUndelineText(text: l10n.language),
              ),
              const SizedBox(height: 10,),
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/themes'),
                child: SmallTitleUndelineText(text: l10n.changetheme),
              ),
              const SizedBox(height: 10,),
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/profile'),
                child: SmallTitleUndelineText(text: l10n.useracc),
              ),
              const SizedBox(height: 10,),
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/critique'),
                child: SmallTitleUndelineText(text: l10n.reporterror),
              ),
              Spacer(flex: 3,),
              BodySmallText(l10n.impressum),
              Spacer(flex: 1,),
            ],
          ),
        ),
      ),
    );
  }
}