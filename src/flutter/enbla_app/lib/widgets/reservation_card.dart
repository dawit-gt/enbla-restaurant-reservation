import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'primary_button.dart';
class ReservationCard extends StatelessWidget {
  final List<InlineSpan> lines;
  final String primaryButtonLabel;
  final VoidCallback onPrimaryPressed;
  final String? secondaryButtonLabel;
  final VoidCallback? onSecondaryPressed;

  const ReservationCard({
    super.key,
    required this.lines,
    required this.primaryButtonLabel,
    required this.onPrimaryPressed,
    this.secondaryButtonLabel,
    this.onSecondaryPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppTheme.lightCard,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...lines.map(
            (span) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: RichText(text: span),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: PrimaryButton(
                  label: primaryButtonLabel,
                  onPressed: onPrimaryPressed,
                  width: double.infinity,
                ),
              ),
              if (secondaryButtonLabel != null &&
                  onSecondaryPressed != null) ...[
                const SizedBox(width: 12),
                Expanded(
                  child: PrimaryButton(
                    label: secondaryButtonLabel!,
                    onPressed: onSecondaryPressed!,
                    width: double.infinity,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

// Uses PrimaryButton from the same folder

