// lib/widgets/text_input_field.dart
import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscure;
  final int maxLines;

  const TextInputField({
    super.key,
    required this.controller,
    required this.hintText,
    this.obscure = false,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      maxLines: maxLines,
      decoration: InputDecoration(hintText: hintText),
    );
  }
}
