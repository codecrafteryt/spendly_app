import 'package:flutter/material.dart';

import '../../utils/values/app_colors.dart';
import '../../utils/values/app_spacing.dart';

class QuizProgressBar extends StatelessWidget {
  const QuizProgressBar({super.key, required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
        child: LinearProgressIndicator(
          value: progress,
          minHeight: AppSpacing.progressHeight,
          backgroundColor: AppColors.lightBorder,
          valueColor: const AlwaysStoppedAnimation(AppColors.accent),
        ),
      ),
    );
  }
}
