import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendly_app/controller/payment_controller/jazzcash_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../utils/values/app_strings.dart';

class PaymentWebView extends StatefulWidget {
  const PaymentWebView({super.key});

  @override
  State<PaymentWebView> createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
  late final JazzCashController _ctrl;
  WebViewController? _webCtrl;

  @override
  void initState() {
    super.initState();
    _ctrl = Get.find<JazzCashController>();
    ever(_ctrl.checkoutHtml, (_) => _initWebView());
    if (_ctrl.checkoutHtml.value.isNotEmpty) _initWebView();
  }

  void _initWebView() {
    if (_ctrl.checkoutHtml.value.isEmpty) return;
    _webCtrl = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (req) {
            final url = req.url;
            if (url.contains('spendly.app/payment/callback') ||
                url.contains('success') ||
                url.contains('fail') ||
                url.contains('cancel')) {
              _ctrl.handleCallback(url);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadHtmlString(_ctrl.checkoutHtml.value);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.paymentJazzCash)),
      body: Obx(() {
        if (_ctrl.isLoading.value || _webCtrl == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return WebViewWidget(controller: _webCtrl!);
      }),
    );
  }
}
