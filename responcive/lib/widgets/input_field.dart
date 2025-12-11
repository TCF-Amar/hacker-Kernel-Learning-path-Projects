import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String labelText;
  final TextEditingController textEditingController;
  final String hintText;

  const InputField({
    super.key,
    required this.labelText,
    required this.textEditingController,
    required this.hintText
    ,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(

        controller: textEditingController,
        style: TextStyle(
          color: Theme.of(context).colorScheme.secondary
        ),
        decoration: InputDecoration(

          labelText: labelText,
          hintText: hintText,
        ),
      ),
    );
  }
}
