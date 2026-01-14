// lib/widgets/primary_button.dart
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF7B3738),
          foregroundColor: const Color(0xFFD9C3A5),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          shape: const StadiumBorder(),
        ),
        child: Text(label),
      ),
    );
  }
}
