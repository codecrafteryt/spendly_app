import 'package:get/get.dart';
import 'package:spendly_app/core/routes/app_routes.dart';
import 'package:spendly_app/services/payment_services/stripe_service.dart';
import 'package:spendly_app/controller/report_controller/session_controller.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class PaymentController extends GetxController {
  PaymentController({StripeService? stripe}) : _stripe = stripe ?? StripeService();

  final StripeService _stripe;
  final RxBool isProcessing = false.obs;
  final RxString errorMessage = ''.obs;

  SessionController get _session => Get.find<SessionController>();

  Future<void> payWithCard() async {
    isProcessing.value = true;
    errorMessage.value = '';
    try {
      final sessionId = _session.sessionId.value.isEmpty
          ? DateTime.now().millisecondsSinceEpoch.toString()
          : _session.sessionId.value;
      _session.sessionId.value = sessionId;
      await _stripe.presentPaymentSheet(sessionId);
      _session.unlockReport();
      Get.offNamed(AppRoutes.fullReport);
    } on StripeException catch (e) {
      if (e.error.code != FailureCode.Canceled) {
        errorMessage.value = e.error.localizedMessage ?? 'Payment failed';
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isProcessing.value = false;
    }
  }

  void goToJazzCash() => Get.toNamed(AppRoutes.paymentWebView);
}
