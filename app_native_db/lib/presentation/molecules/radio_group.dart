import 'package:flutter/material.dart';
import 'package:app_native_db/presentation/atoms/app_text.dart';

class AppRadioGroup<T> extends StatelessWidget {
  final String title;
  final T groupValue;
  final ValueChanged<T?> onChanged;
  final List<AppRadioOption<T>> options;

  const AppRadioGroup({
    super.key,
    required this.title,
    required this.groupValue,
    required this.onChanged,
    required this.options,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.label(title),
        const SizedBox(height: 8),
        ...options.map(
          (option) => RadioListTile<T>(
            title: AppText.body(option.label),
            value: option.value,
            groupValue: groupValue,
            onChanged: onChanged,
            contentPadding: EdgeInsets.zero,
            activeColor: Colors.teal,
          ),
        ),
      ],
    );
  }
}

class AppRadioOption<T> {
  final String label;
  final T value;

  AppRadioOption({required this.label, required this.value});
}
