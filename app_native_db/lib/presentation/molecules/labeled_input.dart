import 'package:flutter/material.dart';
import 'package:app_native_db/presentation/atoms/app_input.dart';
import 'package:app_native_db/presentation/atoms/app_text.dart';

class LabeledInput extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const LabeledInput({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.label(label),
        const SizedBox(height: 8),
        AppInput(
          hint: hint,
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
        ),
      ],
    );
  }
}
