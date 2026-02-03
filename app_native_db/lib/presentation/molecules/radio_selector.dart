import 'package:flutter/material.dart';

class RadioSelector<T> extends StatelessWidget {
  final String title;
  final T groupValue;
  final List<RadioOption<T>> options;
  final ValueChanged<T?> onChanged;

  const RadioSelector({
    super.key,
    required this.title,
    required this.groupValue,
    required this.options,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ),
        Column(
          children: options.map((option) {
            return RadioListTile<T>(
              title: Text(option.label),
              value: option.value,
              groupValue: groupValue,
              onChanged: onChanged,
            );
          }).toList(),
        ),
      ],
    );
  }
}

class RadioOption<T> {
  final String label;
  final T value;

  RadioOption({required this.label, required this.value});
}
