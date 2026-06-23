import 'package:cloud_functions/cloud_functions.dart';
import 'package:get/get.dart';
import 'package:spendly_app/core/utils/firebase_initializer.dart';
import 'package:spendly_app/controller/auth_controller/splash_controller.dart';
import 'package:spendly_app/controller/onboarding_controller/onboarding_controller.dart';
import 'package:spendly_app/controller/payment_controller/jazzcash_controller.dart';
import 'package:spendly_app/controller/payment_controller/payment_controller.dart';
import 'package:spendly_app/controller/quiz_controller/quiz_controller.dart';
import 'package:spendly_app/controller/report_controller/full_report_controller.dart';
import 'package:spendly_app/controller/report_controller/report_controller.dart';
import 'package:spendly_app/controller/report_controller/session_controller.dart';
import 'package:spendly_app/controller/theme_controller.dart';
import 'package:spendly_app/services/ai_services/ai_service.dart';
import 'package:spendly_app/services/payment_services/jazzcash_service.dart';
import 'package:spendly_app/services/payment_services/stripe_service.dart';

class DependencyInjection {
  static Future<void> init() async {
    Get.put<ThemeController>(ThemeController(), permanent: true);
    Get.put<SessionController>(SessionController(), permanent: true);

    Get.lazyPut<StripeService>(
      () => StripeService(
        functions: isFirebaseReady ? FirebaseFunctions.instance : null,
      ),
      fenix: true,
    );
    Get.lazyPut<AiService>(
      () => AiService(
        functions: isFirebaseReady ? FirebaseFunctions.instance : null,
      ),
      fenix: true,
    );
    Get.lazyPut<JazzCashService>(() => JazzCashService(), fenix: true);
  }
}

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SplashController>(SplashController());
  }
}

class OnboardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnboardingController>(() => OnboardingController());
  }
}

class QuizBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QuizController>(() => QuizController());
  }
}

class ReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReportController>(
      () => ReportController(aiService: Get.find<AiService>()),
    );
  }
}

class PaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentController>(
      () => PaymentController(stripe: Get.find<StripeService>()),
    );
    Get.lazyPut<JazzCashController>(
      () => JazzCashController(service: Get.find<JazzCashService>()),
    );
  }
}

class FullReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FullReportController>(() => FullReportController());
  }
}
