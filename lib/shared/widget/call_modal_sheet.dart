import 'package:flutter/material.dart';
import 'package:nvc_cinemas/feature/movie/widget/comment_widget.dart';
import 'package:nvc_cinemas/feature/payment/widget/payment_qr.dart';
import 'package:nvc_cinemas/feature/user/widget/edit_account_information.dart';

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

  static Future<void> editAccountInformation(
    BuildContext context,
  ) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      barrierColor: Colors.black.withOpacity(0.2),
      backgroundColor: Colors.transparent,
      builder: (context) => EditAccountInformationModalSheet(),
    );
  }

  static Future<void> commentMovie(
    BuildContext context,
  ) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      barrierColor: Colors.black.withOpacity(0.2),
      backgroundColor: Colors.transparent,
      builder: (context) => CommentModalSheet(),
    );
  }
}