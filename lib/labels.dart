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
  final bool valid;

  const BoxInputLabel({
    super.key,
    required this.controller,
    this.placeholder = "...",
    this.valid = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: placeholder,
        hintStyle: TextStyle(color: valid ? Colors.grey : Colors.red),
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
  final double? width;
  final bool valid;

  const NumberInputLabel({
    super.key,
    required this.controller,
    this.placeholder = "...",
    this.width = 60,
    this.valid = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'Inter',
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: valid ? Colors.black : Colors.red,
        ),
        decoration: InputDecoration(
          isDense: true,
          hintText: placeholder,
          contentPadding: const EdgeInsets.symmetric(vertical: 4),
          hintStyle: TextStyle(color: valid ? Color(0xFFB3B3B3) : Colors.red),
          border: UnderlineInputBorder(borderSide: BorderSide(color: valid ? Colors.black : Colors.red)),
        ),
      ),
    );
  }
}

class DurationChooser extends StatefulWidget {
  final String duration;

  const DurationChooser ({
    super.key,
    required this.duration
  });

  @override
  State<StatefulWidget> createState() => _DurationChooserState(duration: duration);
}

class _DurationChooserState extends State<DurationChooser> {
  late String duration;

  _DurationChooserState ({
    required this.duration
  });

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context)!;
    final units = [l10n.hour, l10n.minute];

    if (!units.contains(duration)) {
      duration = l10n.minute;
    }

    final reorderedDurations = [
      duration,
      ...units.where((opt) => opt != duration)
    ];

    return PopupMenuButton<String>(
      onSelected: (String value) {
        setState(() {
          duration = value;
        });
      },
      offset: const Offset(0, -20),
      itemBuilder: (BuildContext context) {
        return reorderedDurations.map((String choice) {
          return PopupMenuItem<String>(
            value: choice,
            child: Text(
              choice,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Colors.black,
                letterSpacing: 2,
              ),
            ),
          );
        }).toList();
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide.none,
      ),
      color: Colors.white,
      elevation: 0,
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          SizedBox(height: 7,),
          Text(
            duration,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              fontSize: 14,

              letterSpacing: 2,
              shadows: [
                Shadow(
                    color: Colors.black,
                    offset: Offset(0, -4))
              ],
              color: Colors.transparent,
              decoration: TextDecoration.underline,
              decorationColor: Colors.black,
              decorationThickness: 0.7
            )
          ),
        ],
      )
    );
  }
}

class StringInputLabel extends StatelessWidget {
  final String? placeholder;
  final TextEditingController controller;
  final double? width;
  final bool valid;

  const StringInputLabel({
    super.key,
    required this.controller,
    this.placeholder = "...",
    this.width = 200,
    this.valid = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextField(
        controller: controller,
        style: TextStyle(
        fontFamily: 'Inter',
        fontWeight: FontWeight.w500,
        fontSize: 14,
        color: valid ? Colors.black : Colors.red,
      ),
        decoration: InputDecoration(
          isDense: true,
          hintText: placeholder,
          contentPadding: EdgeInsets.symmetric(vertical: 4),
          border: UnderlineInputBorder(borderSide: BorderSide(color: valid ? Colors.black : Colors.red)),
          labelStyle: TextStyle(color: valid ? Color(0xFFB3B3B3) : Colors.red),
          hintStyle: TextStyle(color: valid ? Color(0xFFB3B3B3) : Colors.red)
        ),
      ),
    );
  }
}