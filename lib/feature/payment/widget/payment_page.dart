import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/feature/auth/provider/auth_provider.dart';
import 'package:nvc_cinemas/feature/movie/widget/date_booking_widget.dart';
import 'package:nvc_cinemas/feature/movie/widget/time_booking_widget.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:nvc_cinemas/l10n/l10n.dart';
import 'package:nvc_cinemas/shared/widget/arrow_back_title.dart';
import 'package:nvc_cinemas/shared/widget/call_modal_sheet.dart';
import 'package:nvc_cinemas/shared/widget/rounded_button_widget.dart';
import 'package:nvc_cinemas/shared/widget/seat_title_widget.dart';
import 'package:nvc_cinemas/shared/widget/seat_type_widget.dart';
import 'package:nvc_cinemas/shared/widget/select/seat_widget.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class PaymentPage extends ConsumerWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    final inset = MediaQuery.of(context).viewInsets;
    final height = size.height - (padding.top + padding.bottom + inset.bottom);
    final width = size.width - (padding.left + padding.right + inset.right);
    final ratio = height / size.width;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: ColorName.pageBackground,
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          children: [
            SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new ExactAssetImage(
                        'assets/images/payment-gateway.png'),
                    fit: BoxFit.contain,
                  ),
                ),
                child: BackdropFilter(
                  filter: new ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                  child: Container(
                    decoration: new BoxDecoration(
                      color: ColorName.pageBackground.withOpacity(0.7),
                    ),
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        ArrowBackTitle(
                          title: context.l10n.pay,
                          textSize: 19,
                          onPressed: () => Navigator.pop(context),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Ngôi làng của lá và sự trở lại của Max cùng với Elise',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: ColorName.btnText,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          '${context.l10n.twoDimensionalSubtitle} | '
                          '104 phút | '
                          'Tâm lý, hành động',
                          style: TextStyle(
                            color: ColorName.btnText,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        rowInformation(
                          title: context.l10n.cinemas,
                          content: 'NVC Cinemas Van Phuc',
                          width: width,
                        ),
                        rowInformation(
                          title: context.l10n.dateShow,
                          content: '13/02/2023',
                          width: width,
                        ),
                        rowInformation(
                          title: context.l10n.timeShow,
                          content: '11:20',
                          width: width,
                        ),
                        rowInformation(
                          title: context.l10n.roomShow,
                          content: 'P12',
                          width: width,
                        ),
                        rowInformation(
                          title: context.l10n.seat,
                          content: 'D7',
                          width: width,
                        ),
                        rowInformation(
                          title: context.l10n.ticketType,
                          content: 'VIP',
                          width: width,
                        ),
                        rowInformation(
                          title: context.l10n.couponCode,
                          content: 'COU15',
                          width: width,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Divider(
                          color: ColorName.btnText,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        rowPaymentInformation(
                          title: context.l10n.total,
                          content: '60.000đ',
                        ),
                        rowPaymentInformation(
                          title: context.l10n.discountPrice,
                          content: '15.000đ',
                          isDiscount: true,
                        ),
                        rowPaymentInformation(
                          title: context.l10n.needPay,
                          content: '60.000đ',
                        ),
                        const Divider(
                          color: ColorName.btnText,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  context.l10n.pay.toUpperCase(),
                                  style: TextStyle(
                                    color: ColorName.textNormal,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Column(
                                  children: [
                                    Icon(
                                      Icons.credit_card_outlined,
                                      size: 30,
                                      color: ColorName.textNormal,
                                    ),
                                    Text(
                                      context.l10n.bank,
                                      style: TextStyle(
                                        color: ColorName.textNormal,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        RoundedLoadingButton(
                          color: ColorName.primary,
                          borderRadius: 5,
                          height: 50,
                          width: 300,
                          animateOnTap: false,
                          controller: ref.watch(authProvider).buttonController,
                          onPressed: () =>
                              CallModalSheet.showPaymentQrModalSheet(context),
                          child: Text(
                            context.l10n.pay.toUpperCase(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget rowInformation({
    required String title,
    required String content,
    required double width,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: width * 0.3,
            child: Text(
              title,
              style: TextStyle(
                overflow: TextOverflow.clip,
                fontSize: 17,
                color: ColorName.textNormal,
              ),
            ),
          ),
          SizedBox(
            width: width * 0.6,
            child: Text(
              content,
              style: TextStyle(
                letterSpacing: 0.9,
                overflow: TextOverflow.clip,
                fontSize: 17,
                color: ColorName.textNormal,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget rowPaymentInformation({
    required String title,
    required String content,
    bool? isDiscount,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                overflow: TextOverflow.clip,
                fontSize: 17,
                color: ColorName.textNormal,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              content,
              textAlign: TextAlign.end,
              style: TextStyle(
                letterSpacing: 0.9,
                overflow: TextOverflow.clip,
                fontSize: 20,
                color: isDiscount ?? false ? ColorName.textNormal : Colors.red,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
