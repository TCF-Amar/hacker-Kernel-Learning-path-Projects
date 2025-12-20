import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputField extends StatelessWidget {
  final String text;
  final String label;
  final bool? isNumber;
  final TextEditingController controller;

  const InputField({
    super.key,
    required this.text,
    required this.label,
    required this.controller,
    this.isNumber,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      inputFormatters: [
        FilteringTextInputFormatter.allow(
          isNumber == true ? RegExp(r'[0-9]') : RegExp(r'[a-zA-Z0-9]'),
        ),
      ],
      decoration: InputDecoration(
        label: Text(label),
        hintText: text,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          gapPadding: 10,
        ),
      ),
      controller: controller,
    );
  }
}
