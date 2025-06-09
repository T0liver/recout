import 'package:flutter/material.dart';
import 'package:recout/l10n/l10n.dart';
import 'package:recout/themes/app_colors.dart';

class TextLabel extends StatelessWidget {
  final TextEditingController controller;
  final String? hint;
  final bool pass;
  final List<String> autofillHint;

  const TextLabel({
    super.key,
    required this.controller,
    this.hint,
    this.autofillHint = const [],
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
            hintStyle: TextStyle(
              color: context.secondaryColor,
              fontWeight: FontWeight.w600,
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: context.secondaryColor,
                width: 1.5,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: context.secondaryColor,
                width: 1.5,
              ),
            ),
          ),
          style: TextStyle(
            color: context.textColor,
            fontWeight: FontWeight.normal,
          ),
          autofillHints: autofillHint,
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
            hintStyle: TextStyle(
              color: context.secondaryColor,
              fontWeight: FontWeight.w600,
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: context.secondaryColor,
                width: 1.5,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: context.secondaryColor,
                width: 1.5,
              ),
            ),
            suffixIcon: IconButton(
              // TODO: add pixelated icons here
              icon: Icon(
                _obscure ? Icons.visibility_off : Icons.visibility,
                color: context.secondaryColor,
              ),
              onPressed: _toggleVisibility,
            ),
          ),
          style: TextStyle(
            color: context.textColor,
            fontWeight: FontWeight.normal,
          ),
          autofillHints: const [AutofillHints.password],
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
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        hintText: placeholder,
        hintStyle: TextStyle(color: valid ? context.tertiaryColor : Theme.of(context).colorScheme.error),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        filled: true,
        fillColor: context.secondaryColor,
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
  final double fontSize;

  const NumberInputLabel({
    super.key,
    required this.controller,
    this.placeholder = "...",
    this.width = 60,
    this.valid = true,
    this.fontSize = 14
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
          fontSize: fontSize,
          color: valid ? context.textColor : Theme.of(context).colorScheme.error,
        ),
        decoration: InputDecoration(
          isDense: true,
          hintText: placeholder,
          contentPadding: const EdgeInsets.symmetric(vertical: 4),
          hintStyle: TextStyle(color: valid ? context.secondaryColor : Theme.of(context).colorScheme.error),
          border: UnderlineInputBorder(borderSide: BorderSide(color: valid ? context.textColor : Theme.of(context).colorScheme.error)),
        ),
      ),
    );
  }
}

class DurationChooser extends StatefulWidget {
  final ValueNotifier<String> duration;

  const DurationChooser ({
    super.key,
    required this.duration
  });

  @override
  State<StatefulWidget> createState() => _DurationChooserState();
}

class _DurationChooserState extends State<DurationChooser> {
  late String duration = L10n.of(context)!.minute;
  late VoidCallback _listener;

  @override
  void initState() {
    super.initState();
    duration = widget.duration.value;

    _listener = () {
      setState(() {
        duration = widget.duration.value;
      });
    };

    widget.duration.addListener(_listener);
  }
  
  @override
  void dispose() {
    widget.duration.removeListener(_listener);
    super.dispose();
  }

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
          widget.duration.value = value;
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
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: context.textColor,
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
      color: context.backgroundColor,
      elevation: 0,
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          SizedBox(height: 7,),
          Text(
            duration,
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              fontSize: 14,

              letterSpacing: 2,
              shadows: [
                Shadow(
                    color: context.textColor,
                    offset: Offset(0, -4))
              ],
              color: Colors.transparent,
              decoration: TextDecoration.underline,
              decorationColor: context.textColor,
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
        textCapitalization: TextCapitalization.sentences,
        style: TextStyle(
          fontFamily: 'Inter',
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: valid ? context.textColor : Theme.of(context).colorScheme.error,
        ),
        decoration: InputDecoration(
          isDense: true,
          hintText: placeholder,
          contentPadding: EdgeInsets.symmetric(vertical: 4),
          border: UnderlineInputBorder(borderSide: BorderSide(color: valid ? Colors.black : Theme.of(context).colorScheme.error)),
          labelStyle: TextStyle(color: valid ? context.secondaryColor : Theme.of(context).colorScheme.error),
          hintStyle: TextStyle(color: valid ? context.secondaryColor : Theme.of(context).colorScheme.error)
        ),
      ),
    );
  }
}

class SmallTitleUndelineInputLabel extends StatelessWidget {
  final String? placeholder;
  final TextEditingController controller;
  final bool valid;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final Divider divider;
  final double maxwidth;
  final bool center;

  const SmallTitleUndelineInputLabel({
    super.key,
    required this.controller,
    this.placeholder = "...",
    this.valid = true,
    this.style,
    this.hintStyle,
    this.divider = const Divider(height: 1, thickness: 0.8),
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
          TextField(
            textAlign: center ? TextAlign.center : TextAlign.start,
            controller: controller,
            textCapitalization: TextCapitalization.sentences,
            style: style ?? TextStyle(
                fontFamily: 'Inter',
                fontSize: 24,
                fontWeight: FontWeight.w400,
                color: context.textColor
            ),
            decoration: InputDecoration(
              hintText: placeholder,
              border: InputBorder.none,
              hintStyle: hintStyle ?? TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  color: context.secondaryColor
              )
            ),
          ),
          const SizedBox(height: 8),
          const Divider(height: 2, thickness: 1),
        ],
      ),
    );
  }
}