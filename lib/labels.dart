import 'package:flutter/material.dart';
import 'package:recout/l10n/l10n.dart';

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

class PasswordLabel extends StatefulWidget {
  final TextEditingController controller;
  final String? hint;

  const PasswordLabel({
    super.key,
    required this.controller,
    this.hint
  });
  @override
  State<StatefulWidget> createState() => _PasswordLabelState();
}

class _PasswordLabelState extends State<PasswordLabel> {
  bool _obscure = true;

  void _toggleVisibility() {
    setState(() {
      _obscure = !_obscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 300),
        child: TextField(
          controller: widget.controller,
          obscureText: _obscure,
          decoration: InputDecoration(
            hintText: widget.hint,
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
            suffixIcon: IconButton(
              // TODO: add pixelated icons here
              icon: Icon(
                _obscure ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey,
              ),
              onPressed: _toggleVisibility,
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

class BoxInputLabel extends StatelessWidget {
  final String? placeholder;
  final TextEditingController controller;

  const BoxInputLabel({
    super.key,
    required this.controller,
    this.placeholder = "...",
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: placeholder,
        hintStyle: const TextStyle(color: Colors.grey),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class NumberInputLabel extends StatelessWidget {
  final String? placeholder;
  final TextEditingController controller;

  const NumberInputLabel({
    super.key,
    required this.controller,
    this.placeholder = "...",
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          isDense: true,
          hintText: placeholder,
          contentPadding: const EdgeInsets.symmetric(vertical: 4),
          border: const UnderlineInputBorder(),
        ),
      ),
    );
  }
}

class DurationChooser extends StatefulWidget {
  String duration;

  DurationChooser ({
    super.key,
    required this.duration
  });

  @override
  State<StatefulWidget> createState() => _DurationChooserState(duration: duration);
}

class _DurationChooserState extends State<DurationChooser> {
  String duration;

  _DurationChooserState ({
    required this.duration
  });

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context)!;
    return DropdownButton<String>(
      value: duration,
      underline: const SizedBox(),
      items: [l10n.hour,].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value, style: const TextStyle(decoration: TextDecoration.underline)),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          duration = newValue!;
        });
      },
    );
  }
}

class StringInputLabel extends StatelessWidget {
  final String? placeholder;
  final TextEditingController controller;

  const StringInputLabel({
    super.key,
    required this.controller,
    this.placeholder = "...",
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        controller: controller,
        style: const TextStyle(
          color: Colors.grey,
          decoration: TextDecoration.underline,
        ),
        decoration: const InputDecoration(border: InputBorder.none),
      ),
    );
  }
}