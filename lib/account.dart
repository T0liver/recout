import 'package:flutter/material.dart';
import 'package:recout/texts.dart';

import 'button.dart';
import 'l10n/l10n.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

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
              Spacer(),
              const BackBtn(),
              Spacer(),
              TitleUndelineText(text: l10n.useracc),
              Spacer(),
              Image.asset('assets/graphics/icons/icons8-test-account-128.png', height: 128,),
              SmallTitleUndelineText(text: '[felhasználónév]', center: true,),
              Spacer(),
              SmallTitleUndelineText(text: '[vezetéknévnév][keresztnév]', center: true,),
              Spacer(),
              SmallTitleUndelineText(text: '[születési idő]', center: true,),
              Spacer(),
              SmallTitleUndelineText(text: '[e-mail cím ]', center: true,),
              Spacer(),
              Button(text: l10n.editdatas, onPressed: () {}),
              Spacer(),
              Button(
                  text: l10n.deleteacc, onPressed: () {},
                  bgColor: Colors.white,
                  border: const BorderSide(width: 2, color: Color(0xFFF9DC5C))
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}