import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recout/ui/legos/texts.dart';
import 'package:recout/data/states/theme_provider.dart';

import '../legos/button.dart';
import '../../l10n/l10n.dart';

class ThemePage extends StatelessWidget {
  const ThemePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context)!;
    final themeProvider = Provider.of<ThemeProvider>(context);
    final double width =
    MediaQuery.of(context).size.width * 0.9 < 700
        ? MediaQuery.of(context).size.width * 0.9
        : 700;
    return Center(
      child: SizedBox(
        width: width,
        child: Column(
          children: [
            const BackBtn(),
            SizedBox(height: 20),
            TitleUndelineText(text: l10n.theme),
            const SizedBox(height: 20,),
            for (final entry in ThemeProvider.themes.entries) ...[
              TextButton(
                  onPressed: () {
                    themeProvider.setTheme(entry.key);
                  },
                  child: SmallTitleUndelineText(text: themeProvider.getThemeName(context, entry.key))
              )
            ],

            Spacer(flex: 3,),
            BodySmallText(l10n.helptheme),
            Spacer(flex: 1,),
          ],
        ),
      )
    );
  }
}