import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendly_app/core/routes/app_routes.dart';
import 'package:spendly_app/controller/report_controller/session_controller.dart';
import 'package:spendly_app/controller/theme_controller.dart';

import '../../utils/values/app_colors.dart';
import '../../utils/values/app_spacing.dart';
import '../../utils/values/app_strings.dart';
import '../widget/app_card.dart';
import '../widget/primary_button.dart';
import '../widget/section_header.dart';

class ResultsPreviewView extends GetView<SessionController> {
  const ResultsPreviewView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.resultsTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6_outlined),
            onPressed: () => Get.find<ThemeController>().toggleDarkLight(),
          ),
        ],
      ),
      body: Obx(() {
        final type = controller.spenderType.value;
        if (type == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppCard(
                child: Column(
                  children: [
                    Icon(Icons.stars, size: AppSpacing.xxl, color: AppColors.accent),
                    const SizedBox(height: AppSpacing.sm),
                    Text(type.label, style: theme.textTheme.headlineSmall),
                  ],
                ),
              ),
              SectionHeader(title: AppStrings.resultsFreeTip),
              AppCard(child: Text(controller.previewTip.value)),
              const SizedBox(height: AppSpacing.lg),
              SectionHeader(title: AppStrings.resultsLocked),
              Stack(
                children: [
                  AppCard(
                    child: Text(
                      controller.reportText.value.isEmpty
                          ? '...'
                          : controller.reportText.value,
                      maxLines: 8,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(AppSpacing.radius),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                        child: Container(
                          color: AppColors.lockedOverlay,
                          child: Center(
                            child: Icon(Icons.lock,
                                color: Colors.white, size: AppSpacing.xxl),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(AppStrings.resultsUnlockPrice,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodySmall),
              const SizedBox(height: AppSpacing.md),
              PrimaryButton(
                label: AppStrings.resultsUnlock,
                onPressed: () => Get.toNamed(AppRoutes.payment),
                icon: Icons.lock_open,
              ),
            ],
          ),
        );
      }),
    );
  }
}
