import 'package:get/get.dart';
import 'package:spendly_app/core/routes/app_routes.dart';
import 'package:spendly_app/services/payment_services/jazzcash_service.dart';
import 'package:spendly_app/controller/report_controller/session_controller.dart';

class JazzCashController extends GetxController {
  JazzCashController({JazzCashService? service})
      : _service = service ?? JazzCashService();

  final JazzCashService _service;
  final RxString checkoutHtml = ''.obs;
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    _loadCheckout();
  }

  void _loadCheckout() {
    final txnRef = 'SP${DateTime.now().millisecondsSinceEpoch}';
    final fields = _service.buildPaymentFields(
      txnRef: txnRef,
      amount: '49900',
      billRef: txnRef,
    );
    checkoutHtml.value = _service.buildCheckoutHtml(fields);
    isLoading.value = false;
  }

  void handleCallback(String url) {
    if (url.contains('success') || url.contains('000')) {
      Get.find<SessionController>().unlockReport();
      Get.offNamed(AppRoutes.fullReport);
    } else if (url.contains('fail') || url.contains('cancel')) {
      Get.back();
    }
  }
}
