import 'package:flutter/material.dart';

import '../../utils/values/app_colors.dart';
import '../../utils/values/app_spacing.dart';

class ProgressDots extends StatelessWidget {
  const ProgressDots({
    super.key,
    required this.total,
    required this.current,
  });

  final int total;
  final int current;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(total, (i) {
        final active = i == current;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
          width: active ? AppSpacing.lg : AppSpacing.sm,
          height: AppSpacing.sm,
          decoration: BoxDecoration(
            color: active ? AppColors.accent : AppColors.lightBorder,
            borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          ),
        );
      }),
    );
  }
}
