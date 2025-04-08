import 'package:flutter/material.dart';

class TextLabel extends StatelessWidget {
  final TextEditingController controller;
  final String? hint;
  final bool pass;

  const TextLabel({
    super.key,
    required this.controller,
    this.hint,
    this.pass = false,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 300),
        child: TextField(
        controller: controller,
        obscureText: pass,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w600,
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
              width: 1.5,
            ),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
              width: 1.5,
            ),
          ),
        ),
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.normal,
        ),
      ),
      ),
    );
  }

}