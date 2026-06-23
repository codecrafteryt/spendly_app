import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendly_app/core/routes/app_routes.dart';
import 'package:spendly_app/controller/payment_controller/payment_controller.dart';

import '../../utils/values/app_spacing.dart';
import '../../utils/values/app_strings.dart';
import '../widget/app_card.dart';
import '../widget/loading_overlay.dart';
import '../widget/section_header.dart';

class PaymentView extends GetView<PaymentController> {
  const PaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.paymentTitle)),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SectionHeader(
                  title: AppStrings.paymentTitle,
                  subtitle: AppStrings.resultsUnlockPrice,
                ),
                AppCard(
                  onTap: controller.payWithCard,
                  child: ListTile(
                    leading: const Icon(Icons.credit_card),
                    title: Text(AppStrings.paymentCard),
                    subtitle: Text(AppStrings.paymentCardSub),
                    trailing: const Icon(Icons.chevron_right),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                AppCard(
                  onTap: () => Get.toNamed(AppRoutes.paymentWebView),
                  child: ListTile(
                    leading: const Icon(Icons.account_balance_wallet),
                    title: Text(AppStrings.paymentJazzCash),
                    subtitle: Text(AppStrings.paymentJazzCashSub),
                    trailing: const Icon(Icons.chevron_right),
                  ),
                ),
                const Spacer(),
                Obx(() {
                  if (controller.errorMessage.value.isEmpty) {
                    return const SizedBox.shrink();
                  }
                  return Text(
                    controller.errorMessage.value,
                    style: TextStyle(color: theme.colorScheme.error),
                    textAlign: TextAlign.center,
                  );
                }),
              ],
            ),
          ),
          Obx(() => LoadingOverlay(
                visible: controller.isProcessing.value,
                message: AppStrings.paymentProcessing,
              )),
        ],
      ),
    );
  }
}
