import 'dart:convert';

import 'package:crypto/crypto.dart';

/// JazzCash / Easypaisa hosted checkout — credentials are placeholders.
class JazzCashService {
  // TODO: insert merchant credentials once approved
  static const ppMerchantId = 'MC_PLACEHOLDER';
  static const ppPassword = 'PASSWORD_PLACEHOLDER';
  static const ppReturnUrl = 'https://spendly.app/payment/callback';
  static const ppIntegritySalt = 'SALT_PLACEHOLDER';
  static const checkoutUrl =
      'https://sandbox.jazzcash.com.pk/CustomerPortal/transactionmanagement/merchantform';

  String buildSecureHash(Map<String, String> fields) {
    final sorted = fields.keys.toList()..sort();
    final buffer = StringBuffer(ppIntegritySalt);
    for (final key in sorted) {
      buffer.write('&${fields[key]}');
    }
    final bytes = utf8.encode(buffer.toString());
    return sha256.convert(bytes).toString();
  }

  Map<String, String> buildPaymentFields({
    required String txnRef,
    required String amount,
    required String billRef,
  }) {
    final fields = <String, String>{
      'pp_Version': '1.1',
      'pp_TxnType': 'MWALLET',
      'pp_Language': 'EN',
      'pp_MerchantID': ppMerchantId,
      'pp_Password': ppPassword,
      'pp_TxnRefNo': txnRef,
      'pp_Amount': amount,
      'pp_TxnCurrency': 'PKR',
      'pp_TxnDateTime': _formatDateTime(DateTime.now()),
      'pp_BillReference': billRef,
      'pp_Description': 'Spendly Report Unlock',
      'pp_ReturnURL': ppReturnUrl,
    };
    fields['pp_SecureHash'] = buildSecureHash(fields);
    return fields;
  }

  String _formatDateTime(DateTime dt) {
    final y = dt.year.toString().padLeft(4, '0');
    final m = dt.month.toString().padLeft(2, '0');
    final d = dt.day.toString().padLeft(2, '0');
    final h = dt.hour.toString().padLeft(2, '0');
    final min = dt.minute.toString().padLeft(2, '0');
    final s = dt.second.toString().padLeft(2, '0');
    return '$y$m$d$h$min$s';
  }

  String buildCheckoutHtml(Map<String, String> fields) {
    final inputs = fields.entries
        .map((e) => '<input type="hidden" name="${e.key}" value="${e.value}"/>')
        .join('\n');
    return '''
<!DOCTYPE html><html><body onload="document.forms[0].submit()">
<form method="POST" action="$checkoutUrl">$inputs</form>
</body></html>''';
  }
}
