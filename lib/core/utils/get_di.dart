import 'package:get/get.dart';
import 'package:spendly_app/controller/theme_controller.dart';
import 'package:spendly_app/controller/report_controller/session_controller.dart';

Future<void> initDependencies() async {
  Get.put(ThemeController(), permanent: true);
  Get.put(SessionController(), permanent: true);
}
