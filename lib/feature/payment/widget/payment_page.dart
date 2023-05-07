import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/feature/auth/provider/auth_provider.dart';
import 'package:nvc_cinemas/feature/m_category/provider/category_provider.dart';
import 'package:nvc_cinemas/feature/m_movie/model/time_model.dart';
import 'package:nvc_cinemas/feature/m_promotion/provider/promotion_provider.dart';
import 'package:nvc_cinemas/feature/m_room/model/room_model.dart';
import 'package:nvc_cinemas/feature/m_room/model/seat_model.dart';
import 'package:nvc_cinemas/feature/m_seat/provider/seat_type_provider.dart';
import 'package:nvc_cinemas/feature/movie/model/movie_model.dart';
import 'package:nvc_cinemas/feature/payment/provider/payment_provider.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:nvc_cinemas/l10n/l10n.dart';
import 'package:nvc_cinemas/shared/provider/util_provider.dart';
import 'package:nvc_cinemas/shared/util/format_support.dart';
import 'package:nvc_cinemas/shared/util/function_ulti.dart';
import 'package:nvc_cinemas/shared/widget/arrow_back_title.dart';
import 'package:nvc_cinemas/shared/widget/call_modal_sheet.dart';
import 'package:nvc_cinemas/shared/widget/dropdown_widget.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class PaymentPage extends ConsumerWidget {
  const PaymentPage({required this.args, Key? key}) : super(key: key);
  final Map<String, dynamic> args;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    final inset = MediaQuery.of(context).viewInsets;
    final height = size.height - (padding.top + padding.bottom + inset.bottom);
    final width = size.width - (padding.left + padding.right + inset.right);
    final ratio = height / size.width;
    final isVietnamese = ref.watch(languageProvider) == 'vi';
    final movie = args['movie'] as MovieModel;
    final time = args['time'] as TimeModel;
    final room = args['room'] as RoomModel;
    final seat = args['seat'] as SeatModel;
    final category =
        ref.read(categoriesProvider.notifier).getById(movie.category!);
    final price =
        ref.read(seatTypesProvider.notifier).getPriceById(seat.seatTypeId!, ref);
    final couponValue = ref.watch(couponCodeProvider);
    final promotions = ref.watch(promotionsProvider);
    final current = DateTime.now().millisecondsSinceEpoch;
    final couponCodeList = <String>['Chọn ưu đãi'];
    if (promotions.isNotEmpty) {
      for (final item in promotions) {
        if (item.startTime! < current &&
            current < item.endTime! &&
            item.code!.isNotEmpty) {
          couponCodeList.add(item.code!);
        }
      }
    }

    var contentCoupon = '';
    final isCouponSelect =
        couponValue.isNotEmpty && couponValue != 'Chọn ưu đãi';
    if (isCouponSelect) {
      contentCoupon = FunctionUtil.couponCodeToContent(context, couponValue);
    }

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
                          isVietnamese
                              ? movie.movieNameVi ?? context.l10n.notUpdated
                              : movie.movieNameEn ?? context.l10n.notUpdated,
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
                          isVietnamese
                              ? '${context.l10n.twoDimensionalSubtitle} | '
                                  '${movie.duration} ${context.l10n.minutes} | '
                                  '${category.categoryName}'
                              : '${context.l10n.twoDimensionalSubtitle} | '
                                  '${movie.duration} ${context.l10n.minutes} | '
                                  '${category.categoryNameEn}',
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
                          content: context.l10n.nvcCinemasLocation,
                          width: width,
                        ),
                        rowInformation(
                          title: context.l10n.dateShow,
                          content: FormatSupport.toDateTimeNonHour(time.from!),
                          width: width,
                        ),
                        rowInformation(
                          title: context.l10n.timeShow,
                          content: FormatSupport.toDateTimeNonDate(time.from!),
                          width: width,
                        ),
                        rowInformation(
                          title: context.l10n.roomShow,
                          content: room.name ?? context.l10n.notUpdated,
                          width: width,
                        ),
                        rowInformation(
                          title: context.l10n.seat,
                          content: seat.position ?? context.l10n.notUpdated,
                          width: width,
                        ),
                        rowInformation(
                          title: context.l10n.ticketType,
                          content: ref
                                      .read(seatTypesProvider.notifier)
                                      .getById(seat.seatTypeId!)
                                      .typeName! ==
                                  'Ghế thường'
                              ? context.l10n.normalSeat
                              : context.l10n.vipSeat,
                          width: width,
                        ),
                        // rowInformation(
                        //   title: context.l10n.couponCode,
                        //   content: 'COU15',
                        //   width: width,
                        // ),
                        Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            const Divider(
                              color: ColorName.btnText,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  context.l10n.couponCode,
                                  style: TextStyle(
                                    color: ColorName.btnText,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                bottom: 10,
                                left: 5,
                                right: width * 0.3,
                              ),
                              child: DropdownWidget(
                                value: couponValue.isNotEmpty
                                    ? couponValue
                                    : 'Chọn ưu đãi',
                                values: couponCodeList,
                                onChanged: (String value) {
                                  ref
                                      .read(couponCodeProvider.notifier)
                                      .update(value);
                                },
                              ),
                            ),
                            if (couponValue.isNotEmpty &&
                                couponValue != 'Chọn ưu đãi')
                              Text(
                                contentCoupon,
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                          ],
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
                          content:
                              '${FormatSupport.toMoney(int.parse(price))}đ',
                        ),
                        rowPaymentInformation(
                          title: context.l10n.discountPrice,
                          content: isCouponSelect
                              ? '${FormatSupport.toMoney(int.parse(FunctionUtil.couponCodeToDiscount(context, couponValue, price)))}đ'
                              : '0đ',
                          isDiscount: true,
                        ),
                        rowPaymentInformation(
                          title: context.l10n.needPay,
                          content: isCouponSelect
                              ? '${FormatSupport.toMoney(
                                  int.parse(
                                    FunctionUtil.couponCodeToTotalPrice(
                                        context, couponValue, price),
                                  ),
                                )}đ'
                              : '${FormatSupport.toMoney(int.parse(price))}đ',
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
                              CallModalSheet.showPaymentQrModalSheet(
                            context,
                            {
                              'time': time,
                              'seat': seat,
                            },
                          ),
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
