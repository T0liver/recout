import 'package:flutter/material.dart';
import 'package:recout/texts.dart';

import 'button.dart';
import 'l10n/l10n.dart';

class ThemePage extends StatelessWidget {
  const ThemePage({super.key});

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
              TitleUndelineText(text: l10n.theme),
              const SizedBox(height: 20,),
              SmallTitleUndelineText(text: 'Világos'),
              const SizedBox(height: 10,),
              SmallTitleUndelineText(text: 'Sötét'),
              Spacer(flex: 3,),
              BodySmallText(l10n.helptranslate),
              Spacer(flex: 1,),
            ],
          ),
        ),
      ),
    );
  }
}