import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final Color bgColor;
  final Size? size;
  final BorderSide border;
  final VoidCallback onPressed;

  const Button({
    super.key,
    required this.text,
    this.bgColor = const Color(0xFFF9DC5C),
    this.size = const Size(331, 66),
    this.border = const BorderSide(width: 0, color: Color(0xFFF9DC5C)),
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
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: border,
          ),
          elevation: 0,
        ), // style
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                fontSize: 24,
                color: Colors.black
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
          width: 40, height: 40,
          child: IconButton(
              onPressed: () => Navigator.pushNamed(context, '/settings'),
              icon: Image.asset('assets/graphics/icons/icons8-settings-64.png')
          ),
        )
    );
  }
}