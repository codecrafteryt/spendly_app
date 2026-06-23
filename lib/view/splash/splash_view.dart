import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendly_app/controller/auth_controller/splash_controller.dart';

import '../../utils/values/app_colors.dart';
import '../../utils/values/app_spacing.dart';
import '../../utils/values/app_strings.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.account_balance_wallet,
                size: AppSpacing.xxl * 2, color: AppColors.accent),
            const SizedBox(height: AppSpacing.lg),
            Text(AppStrings.appName, style: theme.textTheme.headlineLarge),
            const SizedBox(height: AppSpacing.sm),
            Text(AppStrings.tagline, style: theme.textTheme.bodyMedium),
            const SizedBox(height: AppSpacing.xl),
            const CircularProgressIndicator(),
            const SizedBox(height: AppSpacing.md),
            Text(AppStrings.splashLoading, style: theme.textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
