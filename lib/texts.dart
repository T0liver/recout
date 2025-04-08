import 'package:flutter/material.dart';
import 'package:recout/l10n/l10n.dart';

class Heading extends StatelessWidget {
  final String text;
  final Color? color;
  final Size? size;
  final String? font;
  final double? fontSize;
  final FontWeight? fontWeight;

  const Heading({
    super.key,
    required this.text,
    this.size,
    this.color = Colors.black,
    this.font = "Inter",
    this.fontSize = 48,
    this.fontWeight = FontWeight.w700,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size?.width,
      height: size?.height,
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontFamily: font,
            fontWeight: fontWeight,
            fontSize: fontSize,
            color: color,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class LanguageLabel extends StatelessWidget {

  const LanguageLabel({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context)!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: SizedBox(
            width: 32,
            height: 32,
            child: Image(image: AssetImage('assets/graphics/icons/icons8-communicate-32.png')),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          l10n.setLanguage,
          style: const TextStyle(
            fontFamily: "Inter",
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        )
      ],
    );
  }

}