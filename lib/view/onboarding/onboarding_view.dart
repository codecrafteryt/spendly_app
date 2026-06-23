import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendly_app/controller/onboarding_controller/onboarding_controller.dart';
import 'package:spendly_app/view/widget/onboarding_page.dart';

import '../../utils/values/app_spacing.dart';
import '../../utils/values/app_strings.dart';
import '../widget/primary_button.dart';
import '../widget/progress_dots.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: controller.skip,
                child: Text(AppStrings.onboardingSkip),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: controller.pageController,
                onPageChanged: controller.onPageChanged,
                itemCount: controller.pages.length,
                itemBuilder: (_, i) {
                  final p = controller.pages[i];
                  return OnboardingPage(
                    title: p.$1,
                    body: p.$2,
                    icon: p.$3,
                  );
                },
              ),
            ),
            Obx(() => ProgressDots(
                  total: controller.pages.length,
                  current: controller.currentPage.value,
                )),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Obx(() => PrimaryButton(
                    label: controller.currentPage.value ==
                            controller.pages.length - 1
                        ? AppStrings.onboardingStart
                        : AppStrings.onboardingNext,
                    onPressed: controller.next,
                    icon: Icons.arrow_forward,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
