import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recout/themes/app_colors.dart';

class Button extends StatelessWidget {
  final String text;
  final Color? bgColor;
  final Size? size;
  final BorderSide? border;
  final VoidCallback onPressed;
  final TextStyle? style;
  final EdgeInsetsGeometry padding;

  const Button({
    super.key,
    required this.text,
    this.bgColor,
    this.size = const Size(331, 66),
    this.border,
    this.style,
    this.padding = const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size?.width,
      height: size?.height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor ?? context.buttonColor,
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: border ?? BorderSide(width: 0, color: context.buttonColor),
          ),
          elevation: 0,
        ), // style
        child: Center(
          child: Text(
            text,
            style: style ?? TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                fontSize: 24,
                color: context.textColor,
                height: 1.0
            ),
          ),
        ),
      ),
    );
  }
}

class BackBtn extends StatelessWidget {
  final String? whereto;

  const BackBtn({super.key, this.whereto});

  void goback(BuildContext context) {
    if (whereto != null) {
      context.go(whereto!);
    } else {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return const SizedBox.shrink();
    }
    return Container(
      padding: EdgeInsets.only(top: 30),
      alignment: Alignment(-0.9, 0.9),
      child: SizedBox(
        width: 32, height: 32,
        child: IconButton(
            onPressed: () => goback(context),
            icon: Image.asset('assets/graphics/icons/icons8-back-32.png')
        ),
      )
    );
  }
}

class SettingsBtn extends StatelessWidget {
  const SettingsBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment(0.9, 0.9),
        child: SizedBox(
          width: 50, height: 50,
          child: IconButton(
              onPressed: () => context.push('/settings'),
              icon: Image.asset('assets/graphics/icons/icons8-settings-64.png')
          ),
        )
    );
  }
}

class TextIconBtn extends StatelessWidget {
  final String text;
  final String icon;
  final Size size;
  final Size iconsize;
  final TextStyle? textstyle;
  final VoidCallback onPressed;
  final Color? bgColor;
  final EdgeInsetsGeometry padding;
  final BorderSide? border;
  
  const TextIconBtn({
    super.key,
    this.text = '',
    this.icon = '',
    this.size = const Size(200, 70),
    this.iconsize = const Size(32, 32),
    this.textstyle,
    required this.onPressed,
    this.bgColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      height: size.height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor ?? context.buttonColor,
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: border ?? BorderSide(width: 0, color: context.buttonColor),
          ),
          elevation: 0,
        ), // style
        child: Center(
          child: Row(
            children: [
              Spacer(),
              Text(
                text,
                style: textstyle ?? TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    fontSize: 26,
                    color: context.textColor
                ),
              ),
              Spacer(),
              Image.asset(icon, width: iconsize.width, height: iconsize.height,),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class IconBtn extends StatelessWidget {
  final String icon;
  final Size size;
  final VoidCallback onPressed;
  
  const IconBtn({
    super.key,
    required this.icon,
    this.size = const Size(64, 64),
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width, height: size.height,
      child: IconButton(
          onPressed: onPressed,
          icon: Image.asset(icon, width: size.width, height: size.height,)
      )
    );
  }
}