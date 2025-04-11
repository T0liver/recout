import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final Color bgColor;
  final Size? size;
  final BorderSide border;
  final VoidCallback onPressed;
  final TextStyle style;
  final EdgeInsetsGeometry padding;

  const Button({
    super.key,
    required this.text,
    this.bgColor = const Color(0xFFF9DC5C),
    this.size = const Size(331, 66),
    this.border = const BorderSide(width: 0, color: Color(0xFFF9DC5C)),
    this.style = const TextStyle(
        fontFamily: 'Inter',
        fontWeight: FontWeight.w600,
        fontSize: 24,
        color: Colors.black
    ),
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
          backgroundColor: bgColor,
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: border,
          ),
          elevation: 0,
        ), // style
        child: Center(
          child: Text(
            text,
            style: style,
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
      Navigator.pushNamed(context, whereto!);
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
              onPressed: () => Navigator.pushNamed(context, '/settings'),
              icon: Image.asset('assets/graphics/icons/icons8-settings-64.png')
          ),
        )
    );
  }
}

class IconBtn extends StatelessWidget {
  final String text;
  final String icon;
  final Size size;
  final Size iconsize;
  final TextStyle textstyle;
  final VoidCallback onPressed;
  final Color bgColor;
  final EdgeInsetsGeometry padding;
  final BorderSide border;
  
  const IconBtn({
    super.key,
    this.text = '',
    this.icon = '',
    this.size = const Size(200, 70),
    this.iconsize = const Size(32, 32),
    this.textstyle = const TextStyle(
        fontFamily: 'Inter',
        fontWeight: FontWeight.w600,
        fontSize: 26,
        color: Colors.black
    ),
    required this.onPressed,
    this.bgColor = const Color(0xFFF9DC5C),
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    this.border = const BorderSide(width: 0, color: Color(0xFFF9DC5C)),
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      height: size.height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: border,
          ),
          elevation: 0,
        ), // style
        child: Center(
          child: Row(
            children: [
              Spacer(),
              Text(
                text,
                style: textstyle,
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