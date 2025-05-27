import 'package:flutter/material.dart';
import 'package:recout/l10n/l10n.dart';
import 'package:recout/themes/app_colors.dart';

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
    this.color,
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
          color: color ?? context.textColor,
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
            style: TextStyle(
              fontFamily: "Inter",
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: context.textColor
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
          style: TextStyle(
              fontFamily: "Inter",
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: context.tertiaryColor,
          ),
        ),
        Text(
          "$name!",
          style: TextStyle(
              fontFamily: "Inter",
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: context.textColor
          ),
        )
      ],
    );
  }
}

class BodyStrongText extends StatelessWidget {
  final String text;
  final TextStyle? style;

  const BodyStrongText(this.text, {
    super.key,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: getStyle(context),
    );
  }

  TextStyle getStyle(BuildContext context) {
    return style ?? TextStyle(
        fontFamily: 'Inter',
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: context.textColor
    );
  }
}

class BodySmallText extends StatelessWidget {
  final String text;
  final TextStyle? style;

  const BodySmallText(this.text, {
    super.key,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: getStyle(context),
    );
  }

  TextStyle getStyle(BuildContext context) {
    return style ?? TextStyle(
        fontFamily: 'Inter',
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: context.textColor
    );
  }
}

class BodyBase extends StatelessWidget {
  final String text;
  final TextStyle? style;

  const BodyBase(this.text, {
    super.key,
    this.style = const TextStyle(
        fontFamily: 'Inter',
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Colors.black
    ),
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
    );
  }
}

class BodyBaseButton extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final VoidCallback onPressed;

  const BodyBaseButton(this.text, this.onPressed, {
    super.key,
    this.style = const TextStyle(
        fontFamily: 'Inter',
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Colors.black
    ),
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(Colors.transparent),
          splashFactory: NoSplash.splashFactory,
          overlayColor: WidgetStateProperty.all<Color>(Colors.transparent)
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: style,
      )
    );
  }
}

class TitleUndelineText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final Divider divider;
  final double maxwidth;
  final bool center;

  const TitleUndelineText ({
    super.key,
    required this.text,
    this.style,
    this.divider = const Divider(height: 2, thickness: 1),
    this.maxwidth = 500,
    this.center = false,
  });

  @override
  Widget build(BuildContext context) {
    final double width =
    MediaQuery.of(context).size.width * 0.9 < maxwidth
        ? MediaQuery.of(context).size.width * 0.9
        : maxwidth;

    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: center ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: getStyle(context),
          ),
          const SizedBox(height: 8),
          Divider(height: 2, thickness: 1, color: context.secondaryColor,),
        ],
      ),
    );
  }

  TextStyle getStyle(BuildContext context) {
    return style ?? TextStyle(
        fontFamily: 'Inter',
        fontSize: 26,
        fontWeight: FontWeight.w800,
        color: context.textColor
    );
  }
}

class SmallTitleUndelineText extends TitleUndelineText {
  const SmallTitleUndelineText({
    super.key,
    required super.text,
    super.style,
    super.divider = const Divider(height: 1, thickness: 0.8),
    super.maxwidth = 500,
    super.center,
  });

  @override
  TextStyle getStyle(BuildContext context) {
    return style ?? TextStyle(
        fontFamily: 'Inter',
        fontSize: 24,
        fontWeight: FontWeight.w400,
        color: context.textColor
    );
  }
}