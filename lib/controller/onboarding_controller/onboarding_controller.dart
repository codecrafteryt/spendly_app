import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:spendly_app/core/routes/app_routes.dart';

import '../../utils/values/app_strings.dart';

class OnboardingController extends GetxController {
  static const _key = 'onboarding_complete';
  final pageController = PageController();
  final currentPage = 0.obs;

  final pages = const [
    (AppStrings.onboardingTitle1, AppStrings.onboardingBody1, Icons.quiz_outlined),
    (AppStrings.onboardingTitle2, AppStrings.onboardingBody2, Icons.auto_awesome_outlined),
    (AppStrings.onboardingTitle3, AppStrings.onboardingBody3, Icons.savings_outlined),
  ];

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void onPageChanged(int index) => currentPage.value = index;

  void next() {
    if (currentPage.value < pages.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      startQuiz();
    }
  }

  void skip() => _complete();

  void startQuiz() => _complete();

  void _complete() {
    GetStorage().write(_key, true);
    Get.offNamed(AppRoutes.quiz);
  }
}
