import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recout/l10n/language_provider.dart';
import 'package:recout/ui/legos/texts.dart';

import '../legos/button.dart';
import '../../l10n/l10n.dart';

class LanguagePage extends StatefulWidget {

  const LanguagePage({super.key});

  @override
  State<StatefulWidget> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  late Future<Map<Locale, String>> _languages;

  @override
  void initState() {
    super.initState();
    _languages = loadLanguages(context);
  }

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
            const SizedBox(height: 10),
            const BackBtn(),
            const SizedBox(height: 20),
            TitleUndelineText(text: l10n.language),
            const SizedBox(height: 20),
            FutureBuilder<Map<Locale, String>>(
              future: _languages,
              builder: (context, snapshot) {
                if (!snapshot.hasData) return CircularProgressIndicator();
                final languages = snapshot.data!;
                return Column(
                  children: languages.entries.map((entry) {
                    return TextButton(
                      onPressed: () {
                        Provider.of<LanguageProvider>(context, listen: false)
                            .setLocale(entry.key);
                      },
                        child: SmallTitleUndelineText(text: entry.value)
                    );
                  }).toList(),
                );
              },
            ),
            const Spacer(flex: 3),
            BodySmallText(l10n.helptranslate),
            const Spacer(flex: 1),
          ],
        ),
      ),
    );
  }
}

Future<Map<Locale, String>> loadLanguages(BuildContext context) async {
  final List<Locale> locales = L10n.supportedLocales;
  final Map<Locale, String> names = {};

  for (final locale in locales) {
    final localizations = await L10n.delegate.load(locale);
    names[locale] = localizations.languageName;
  }

  return names;
}