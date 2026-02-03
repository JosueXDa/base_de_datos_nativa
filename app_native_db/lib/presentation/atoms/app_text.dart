import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;

  const AppText(this.text, {super.key, this.style, this.textAlign});

  factory AppText.title(String text) => AppText(
        text,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      );

  factory AppText.body(String text) => AppText(
        text,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black54,
        ),
      );

  factory AppText.label(String text) => AppText(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.blueGrey,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Text(text, style: style, textAlign: textAlign);
  }
}
