import 'package:flutter/material.dart';

import 'package:recout/l10n/l10n.dart';
import 'package:recout/ui/legos/button.dart';
import 'package:recout/ui/legos/texts.dart';
import 'package:recout/themes/app_colors.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context)!;
    return Column(
      children: [
        const Spacer(flex: 2),
        Image.asset('assets/graphics/icons/icons8-strong-arm-128.png', height: MediaQuery.sizeOf(context).height * 0.15,),
        Center(
          child: Heading(text: l10n.firstGreet),
        ),
        const Spacer(flex: 2),
        LanguageLabel(onPressed: () =>Navigator.pushNamed(context, '/languages'),),
        const Spacer(flex: 4),
        Button(text: l10n.login, onPressed: () {
          Navigator.pushNamed(context, '/login');
        }),
        SizedBox(height: 20,),
        Button(text: l10n.register, onPressed: () {
          Navigator.pushNamed(context, '/register');
        },
          bgColor: context.backgroundColor,
          border: BorderSide(color: context.buttonColor, width: 2),
        ),
        const Spacer(flex: 1,)
      ]
    );
  }
}