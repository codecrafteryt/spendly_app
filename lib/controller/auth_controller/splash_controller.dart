import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:spendly_app/core/routes/app_routes.dart';

class SplashController extends GetxController {
  static const _onboardingKey = 'onboarding_complete';

  @override
  void onReady() {
    super.onReady();
    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(seconds: 2));
    final storage = GetStorage();
    final done = storage.read<bool>(_onboardingKey) ?? false;
    Get.offNamed(done ? AppRoutes.quiz : AppRoutes.onboarding);
  }
}
