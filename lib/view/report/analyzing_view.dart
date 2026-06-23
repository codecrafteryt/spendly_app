import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendly_app/controller/report_controller/report_controller.dart';
import 'package:spendly_app/controller/report_controller/session_controller.dart';

import '../../utils/values/app_colors.dart';
import '../../utils/values/app_spacing.dart';
import '../../utils/values/app_strings.dart';
import '../widget/error_state_widget.dart';

class AnalyzingView extends GetView<ReportController> {
  const AnalyzingView({super.key});

  @override
  Widget build(BuildContext context) {
    final session = Get.find<SessionController>();
    final theme = Theme.of(context);
    return Scaffold(
      body: Obx(() {
        final status = session.reportStatus.value;
        if (status == ReportStatus.error) {
          return ErrorStateWidget(
            message: AppStrings.analyzingError,
            retryLabel: AppStrings.analyzingRetry,
            onRetry: controller.generateReport,
          );
        }
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.psychology_outlined,
                    size: AppSpacing.xxl * 2, color: AppColors.accent),
                const SizedBox(height: AppSpacing.lg),
                Text(AppStrings.analyzingTitle,
                    style: theme.textTheme.headlineMedium),
                const SizedBox(height: AppSpacing.sm),
                Text(AppStrings.analyzingSubtitle,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium),
                const SizedBox(height: AppSpacing.xl),
                const CircularProgressIndicator(),
              ],
            ),
          ),
        );
      }),
    );
  }
}
