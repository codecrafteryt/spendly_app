import 'dart:io';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:spendly_app/core/utils/firebase_initializer.dart';

class StripeService {
  StripeService({FirebaseFunctions? functions}) : _functions = functions;

  final FirebaseFunctions? _functions;
  static const publishableKey = 'pk_test_PLACEHOLDER';
  static const amountCents = 499;

  static Future<void> init() async {
    Stripe.publishableKey = publishableKey;
    if (Platform.isAndroid || Platform.isIOS) {
      await Stripe.instance.applySettings();
    }
  }

  Future<void> presentPaymentSheet(String sessionId) async {
    final functions = _functions;
    if (!isFirebaseReady || functions == null) {
      throw Exception(
        'Payments require Firebase. Run flutterfire configure and enable AppConfig.firebaseEnabled.',
      );
    }

    final callable = functions.httpsCallable('createPaymentIntent');
    final result = await callable.call<Map<String, dynamic>>({
      'amount': amountCents,
      'currency': 'usd',
      'sessionId': sessionId,
    });
    final clientSecret = result.data['clientSecret'] as String?;
    if (clientSecret == null) throw Exception('No client secret');

    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: clientSecret,
        merchantDisplayName: 'Spendly',
      ),
    );
    await Stripe.instance.presentPaymentSheet();
  }
}
