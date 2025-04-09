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
    );
  }
}

class LanguageLabel extends StatelessWidget {
  final VoidCallback onPressed;

  const LanguageLabel({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context)!;
    return TextButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(Colors.transparent),
        splashFactory: NoSplash.splashFactory,
        overlayColor: WidgetStateProperty.all<Color>(Colors.transparent)
      ),
      onPressed: onPressed,
      child:  Row(
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
              color: Colors.black
            ),
          )
        ],
      )
    );
  }
}

class HelloText extends StatelessWidget {
  final String name;
  const HelloText({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          L10n.of(context)!.hello,
          style: const TextStyle(
              fontFamily: "Inter",
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF757575),
          ),
        ),
        Text(
          "$name!",
          style: const TextStyle(
              fontFamily: "Inter",
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.black
          ),
        )
      ],
    );
  }
}

class PrevWorksTitle extends StatelessWidget {
  const PrevWorksTitle ({super.key});

  @override
  Widget build(BuildContext context) {
    final double width =
    MediaQuery.of(context).size.width * 0.9 < 500
        ? MediaQuery.of(context).size.width * 0.9
        : 500;
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            L10n.of(context)!.prevworkouts,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 26,
              fontWeight: FontWeight.w500,
              color: Colors.black
            ),
          ),
          const SizedBox(height: 8),
          const Divider(height: 2, thickness: 1),
        ],
      ),
    );
  }
}