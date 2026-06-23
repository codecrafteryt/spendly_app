import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:spendly_app/core/routes/app_pages.dart';
import 'package:spendly_app/core/routes/app_routes.dart';
import 'package:spendly_app/core/utils/firebase_initializer.dart';
import 'package:spendly_app/data/helper/get_di.dart';
import 'package:spendly_app/services/payment_services/stripe_service.dart';
import 'package:spendly_app/controller/theme_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  await initializeFirebase();
  await DependencyInjection.init();

  try {
    await StripeService.init();
  } catch (e) {
    if (kDebugMode) {
      debugPrint('Stripe init skipped: $e');
    }
  }

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const SpendlyApp());
}

class SpendlyApp extends StatelessWidget {
  const SpendlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeCtrl = Get.find<ThemeController>();
    return Obx(
      () => GetMaterialApp(
        title: 'Spendly',
        debugShowCheckedModeBanner: false,
        theme: themeCtrl.lightTheme,
        darkTheme: themeCtrl.darkTheme,
        themeMode: themeCtrl.themeMode,
        initialRoute: AppRoutes.splash,
        initialBinding: SplashBinding(),
        getPages: AppPages.pages,
        defaultTransition: Transition.fadeIn,
      ),
    );
  }
}
