import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendly_app/controller/report_controller/full_report_controller.dart';
import 'package:spendly_app/controller/report_controller/session_controller.dart';
import 'package:spendly_app/view/widget/unlock_reveal.dart';

import '../../utils/values/app_colors.dart';
import '../../utils/values/app_spacing.dart';
import '../../utils/values/app_strings.dart';
import '../widget/loading_overlay.dart';
import '../widget/primary_button.dart';
import '../widget/section_header.dart';

class FullReportView extends GetView<FullReportController> {
  const FullReportView({super.key});

  @override
  Widget build(BuildContext context) {
    final session = Get.find<SessionController>();
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.reportTitle)),
      body: Stack(
        children: [
          Obx(() {
            final type = session.spenderType.value;
            final text = session.reportText.value;
            return UnlockReveal(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (type != null)
                      Chip(
                        label: Text(type.label),
                        backgroundColor:
                            AppColors.accent.withValues(alpha: 0.15),
                      ),
                    const SizedBox(height: AppSpacing.md),
                    SectionHeader(title: AppStrings.reportTitle),
                    Text(text, style: theme.textTheme.bodyLarge),
                    const SizedBox(height: AppSpacing.xl),
                    PrimaryButton(
                      label: AppStrings.reportShare,
                      onPressed: controller.sharePdf,
                      icon: Icons.share,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    PrimaryButton(
                      label: AppStrings.reportDownload,
                      onPressed: controller.downloadPdf,
                      icon: Icons.download,
                    ),
                    if (controller.pdfError.value.isNotEmpty) ...[
                      const SizedBox(height: AppSpacing.md),
                      Text(controller.pdfError.value,
                          style: TextStyle(color: theme.colorScheme.error)),
                    ],
                  ],
                ),
              ),
            );
          }),
          Obx(() => LoadingOverlay(
                visible: session.isPdfLoading.value,
                message: AppStrings.reportGenerating,
              )),
        ],
      ),
    );
  }
}
