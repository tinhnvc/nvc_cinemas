import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/feature/m_movie/model/time_model.dart';
import 'package:nvc_cinemas/feature/m_room/model/seat_model.dart';
import 'package:nvc_cinemas/feature/m_room/provider/m_room_provider.dart';
import 'package:nvc_cinemas/feature/m_seat/provider/seat_type_provider.dart';
import 'package:nvc_cinemas/feature/movie/provider/day_of_week_provider.dart';
import 'package:nvc_cinemas/feature/payment/provider/payment_provider.dart';
import 'package:nvc_cinemas/feature/ticket/model/ticket_model.dart';
import 'package:nvc_cinemas/feature/ticket/provider/ticket_provider.dart';
import 'package:nvc_cinemas/gen/assets.gen.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:nvc_cinemas/l10n/l10n.dart';
import 'package:nvc_cinemas/shared/link/assets.dart';
import 'package:nvc_cinemas/shared/provider/user_provider.dart';
import 'package:nvc_cinemas/shared/util/function_ulti.dart';
import 'package:nvc_cinemas/shared/widget/primary_button_widget.dart';
import 'package:nvc_cinemas/shared/widget/rounded_button_widget.dart';
import 'package:nvc_cinemas/shared/widget/select/selectable_text_custom.dart';
import 'package:nvc_cinemas/shared/widget/snack_bar_support.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:uuid/uuid.dart';

class PaymentQrModalSheet extends ConsumerWidget {
  const PaymentQrModalSheet({required this.args, Key? key}) : super(key: key);
  final Map<String, dynamic> args;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final time = args['time'] as TimeModel;
    final seat = args['seat'] as SeatModel;
    final ticketId = Uuid().v4();
    final seatType =
        ref.read(seatTypesProvider.notifier).getById(seat.seatTypeId!);
    final dayChoose = ref.read(dayOfWeekProvider.notifier).getSelected();
    final day = DateTime.fromMillisecondsSinceEpoch(dayChoose.day!).weekday;
    final today = DateTime.now().weekday;
    final price =
        (day == 6 || day == 7) ? seatType.otherPrice! : seatType.price;

    final couponValue = ref.watch(couponCodeProvider);
    final isCouponSelect =
        couponValue.isNotEmpty && couponValue != 'Chọn ưu đãi';
    final user = ref.watch(userProvider);

    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Stack(
            children: [
              Container(
                height: 50,
                padding: const EdgeInsets.only(
                  left: 25,
                  // top: 10,
                  // bottom: 10,
                  right: 5,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      context.l10n.pay,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Color(0xFF363E59),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 50),
                child: const Divider(
                  height: 3,
                  color: ColorName.textNormal,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 60),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 25,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Assets.images.paymentQr
                                    .image(width: 250, fit: BoxFit.cover),
                              ],
                            ),
                            SelectableTextCustom(
                              text: '${context.l10n.content}: tt $ticketId',
                              style: TextStyle(
                                color: ColorName.btnText,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              bankInformation[0],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: ColorName.btnText,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SelectableTextCustom(
                              text: bankInformation[1],
                              style: TextStyle(
                                color: ColorName.btnText,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            if (user.email != 'customer@nvccinemas.com')
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  RoundedButtonWidget(
                                    content: context.l10n.copyContent,
                                    onPressed: () async {
                                      await FlutterClipboard.copy(
                                        'tt $ticketId',
                                      );
                                      SnackBarSupport.copied(context: context);
                                    },
                                  ),
                                  RoundedButtonWidget(
                                    content: context.l10n.copyBank,
                                    onPressed: () async {
                                      await FlutterClipboard.copy(
                                        bankInformation[1],
                                      );
                                      SnackBarSupport.copied(context: context);
                                    },
                                  ),
                                ],
                              ),
                            const SizedBox(
                              height: 10,
                            ),
                            user.email == 'customer@nvccinemas.com'
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      RoundedLoadingButton(
                                        color: ColorName.primary,
                                        borderRadius: 5,
                                        height: 40,
                                        width: 160,
                                        animateOnTap: false,
                                        controller: ref
                                            .watch(ticketFormProvider)
                                            .buttonController,
                                        onPressed: () {
                                          final ticket = TicketModel(
                                            id: ticketId,
                                            userId:
                                                ref.watch(userProvider).userId,
                                            timeId: time.id,
                                            seatId: seat.id,
                                            status: 'payed',
                                            discount: isCouponSelect
                                                ? int.parse(FunctionUtil
                                                    .couponCodeToDiscount(
                                                        context,
                                                        couponValue,
                                                        price.toString()))
                                                : 0,
                                            totalPrice: isCouponSelect
                                                ? int.parse(FunctionUtil
                                                    .couponCodeToTotalPrice(
                                                        context,
                                                        couponValue,
                                                        price.toString()))
                                                : price,
                                            createAt: DateTime.now()
                                                .millisecondsSinceEpoch,
                                            updateAt: DateTime.now()
                                                .millisecondsSinceEpoch,
                                          );
                                          ref
                                              .read(ticketFormProvider)
                                              .addTicket(ref, context, ticket);
                                        },
                                        child: Text(
                                          'Đã thanh toán',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      RoundedLoadingButton(
                                        color: ColorName.primary,
                                        borderRadius: 5,
                                        height: 40,
                                        width: 160,
                                        animateOnTap: false,
                                        controller: ref
                                            .watch(roomFormProvider)
                                            .buttonController,
                                        onPressed: () {
                                          ref
                                              .read(roomFormProvider)
                                              .resetButton();
                                          final ticket = TicketModel(
                                            id: ticketId,
                                            userId:
                                                ref.watch(userProvider).userId,
                                            timeId: time.id,
                                            seatId: seat.id,
                                            status: 'waitConfirm',
                                            discount: isCouponSelect
                                                ? int.parse(FunctionUtil
                                                    .couponCodeToDiscount(
                                                        context,
                                                        couponValue,
                                                        price.toString()))
                                                : 0,
                                            totalPrice: isCouponSelect
                                                ? int.parse(FunctionUtil
                                                    .couponCodeToTotalPrice(
                                                        context,
                                                        couponValue,
                                                        price.toString()))
                                                : price,
                                            createAt: DateTime.now()
                                                .millisecondsSinceEpoch,
                                            updateAt: DateTime.now()
                                                .millisecondsSinceEpoch,
                                          );
                                          ref
                                              .read(ticketFormProvider)
                                              .addTicket(ref, context, ticket);
                                        },
                                        child: Text(
                                          'Đã thanh toán',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                      RoundedLoadingButton(
                                        color: ColorName.primary,
                                        borderRadius: 5,
                                        height: 40,
                                        width: 160,
                                        animateOnTap: false,
                                        controller: ref
                                            .watch(seatTypeFormProvider)
                                            .buttonController,
                                        onPressed: () {
                                          ref
                                              .read(seatTypeFormProvider)
                                              .resetButton();
                                          final ticket = TicketModel(
                                            id: ticketId,
                                            userId:
                                                ref.watch(userProvider).userId,
                                            timeId: time.id,
                                            seatId: seat.id,
                                            status: 'waitPay',
                                            discount: isCouponSelect
                                                ? int.parse(FunctionUtil
                                                    .couponCodeToDiscount(
                                                        context,
                                                        couponValue,
                                                        price.toString()))
                                                : 0,
                                            totalPrice: isCouponSelect
                                                ? int.parse(FunctionUtil
                                                    .couponCodeToTotalPrice(
                                                        context,
                                                        couponValue,
                                                        price.toString()))
                                                : price,
                                            createAt: DateTime.now()
                                                .millisecondsSinceEpoch,
                                            updateAt: DateTime.now()
                                                .millisecondsSinceEpoch,
                                          );
                                          ref
                                              .read(ticketFormProvider)
                                              .addTicket(ref, context, ticket);
                                        },
                                        child: Text(
                                          'Thanh toán sau',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                            const SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
