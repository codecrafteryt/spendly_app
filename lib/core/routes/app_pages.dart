import 'package:get/get.dart';
import 'package:spendly_app/core/routes/app_routes.dart';
import 'package:spendly_app/view/splash/splash_view.dart';
import 'package:spendly_app/view/onboarding/onboarding_view.dart';
import 'package:spendly_app/view/quizs/quiz_view.dart';
import 'package:spendly_app/view/report/analyzing_view.dart';
import 'package:spendly_app/view/report/results_preview_view.dart';
import 'package:spendly_app/view/report/full_report_view.dart';
import 'package:spendly_app/view/payment/payment_view.dart';
import 'package:spendly_app/view/payment/payment_webview.dart';

class AppPages {
  AppPages._();

  static final pages = <GetPage>[
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashView(),
    ),
    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.quiz,
      page: () => const QuizView(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.analyzing,
      page: () => const AnalyzingView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.resultsPreview,
      page: () => const ResultsPreviewView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.payment,
      page: () => const PaymentView(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.paymentWebView,
      page: () => const PaymentWebView(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: AppRoutes.fullReport,
      page: () => const FullReportView(),
      transition: Transition.zoom,
    ),
  ];
}
