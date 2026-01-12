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
    // Center the button and size it to its child (text).
    return Center(
      child: ElevatedButton(onPressed: onPressed, child: Text(label)),
    );
  }
}
