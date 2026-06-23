import 'package:flutter/material.dart';
import 'package:spendly_app/view/widget/primary_button.dart';
import '../../utils/values/app_spacing.dart';
import '../../utils/values/app_strings.dart';

class ErrorStateWidget extends StatelessWidget {
  const ErrorStateWidget({
    super.key,
    required this.message,
    required this.onRetry,
    this.retryLabel,
  });

  final String message;
  final VoidCallback onRetry;
  final String? retryLabel;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: AppSpacing.xxl,
                color: Theme.of(context).colorScheme.error),
            const SizedBox(height: AppSpacing.md),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: AppSpacing.lg),
            PrimaryButton(
              label: retryLabel ?? AppStrings.btnRetry,
              onPressed: onRetry,
            ),
          ],
        ),
      ),
    );
  }
}
