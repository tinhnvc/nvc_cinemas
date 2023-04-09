import 'package:flutter/material.dart';
import 'package:nvc_cinemas/feature/payment/widget/payment_qr.dart';

class CallModalSheet {
  static Future<void> showPaymentQrModalSheet(
    BuildContext context,
  ) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      barrierColor: Colors.black.withOpacity(0.2),
      backgroundColor: Colors.transparent,
      builder: (context) => PaymentQrModalSheet(),
    );
  }
}
