// lib/widgets/text_input_field.dart
import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscure;

  const TextInputField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.obscure = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(hintText: hintText),
    );
  }
}
