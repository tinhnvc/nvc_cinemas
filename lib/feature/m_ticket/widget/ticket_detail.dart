import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/feature/auth/provider/users_provider.dart';
import 'package:nvc_cinemas/feature/m_movie/provider/m_movie_provider.dart';
import 'package:nvc_cinemas/feature/m_movie/provider/time_provider.dart';
import 'package:nvc_cinemas/feature/m_room/provider/m_room_provider.dart';
import 'package:nvc_cinemas/feature/m_room/provider/m_seat_provider.dart';
import 'package:nvc_cinemas/feature/ticket/model/ticket_model.dart';
import 'package:nvc_cinemas/feature/ticket/provider/ticket_provider.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:nvc_cinemas/l10n/l10n.dart';
import 'package:nvc_cinemas/shared/provider/util_provider.dart';
import 'package:nvc_cinemas/shared/util/format_support.dart';
import 'package:nvc_cinemas/shared/util/function_ulti.dart';
import 'package:nvc_cinemas/shared/widget/arrow_back_title.dart';
import 'package:nvc_cinemas/shared/widget/rounded_button_widget.dart';
import 'package:nvc_cinemas/shared/widget/select/selectable_text_custom.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class TicketDetail extends ConsumerWidget {
  const TicketDetail({required this.ticket, Key? key}) : super(key: key);
  final TicketModel ticket;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    final inset = MediaQuery.of(context).viewInsets;
    final height = size.height - (padding.top + padding.bottom + inset.bottom);
    final width = size.width - (padding.left + padding.right + inset.right);
    final ratio = height / size.width;
    final isVietnamese = ref.watch(languageProvider) == 'vi';
    final time = ref.read(timesProvider.notifier).getById(ticket.timeId!);
    final movie = ref.read(moviesProvider.notifier).getById(time.movieId!);
    final room = ref.read(roomsProvider.notifier).getById(time.roomId!);
    final seat = ref.read(seatsProvider.notifier).getById(ticket.seatId!);
    final user = ref.read(usersProvider.notifier).getById(ticket.userId!);
    final isNoPay =
        (ticket.status == 'waitPay' || ticket.status == 'waitConfirm');

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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    ArrowBackTitle(
                      title: context.l10n.ticketDetail,
                      textSize: 19,
                      onPressed: () => Navigator.pop(context),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 15,
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: ColorName.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Column(
                          children: [
                            rowInformation(
                              title: context.l10n.ticketId,
                              content: '${ticket.id}',
                              width: width,
                              isSelectable: true,
                            ),
                            rowInformation(
                              title: context.l10n.account,
                              content: '${user.email}',
                              width: width,
                            ),
                            rowInformation(
                              title: context.l10n.fullName,
                              content: '${user.fullName}',
                              width: width,
                            ),
                            rowInformation(
                              title: context.l10n.film,
                              content: isVietnamese
                                  ? movie.movieNameVi ?? context.l10n.notUpdated
                                  : movie.movieNameEn ??
                                      context.l10n.notUpdated,
                              width: width,
                            ),
                            rowInformation(
                              title: context.l10n.dateShow,
                              content:
                                  '${FormatSupport.toDateTimeNonHour(time.from!)}',
                              width: width,
                            ),
                            rowInformation(
                              title: context.l10n.timeShow,
                              content:
                                  '${FormatSupport.toDateTimeNonDate(time.from!)}',
                              width: width,
                            ),
                            rowInformation(
                              title: context.l10n.roomShow,
                              content: '${room.name}',
                              width: width,
                            ),
                            rowInformation(
                              title: context.l10n.seat,
                              content: '${seat.position}',
                              width: width,
                            ),
                            rowInformation(
                              title: context.l10n.createAt,
                              content:
                                  '${FormatSupport.toDateTimeNonSecond(ticket.createAt!)}',
                              width: width,
                            ),
                            rowInformation(
                              title: context.l10n.updateAt,
                              content:
                                  '${FormatSupport.toDateTimeNonSecond(ticket.updateAt!)}',
                              width: width,
                            ),
                            rowStatusTicket(
                              context: context,
                              status: FunctionUtil.ticketStatusToContent(
                                  context, ticket.status ?? 'waitPay'),
                              width: width,
                            ),
                            rowInformation(
                              title: context.l10n.pay,
                              content:
                                  '${FormatSupport.toMoney(ticket.totalPrice ?? 45000)}đ',
                              width: width,
                              isSpecial: true,
                            ),
                            if (isNoPay)
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    RoundedButtonWidget(
                                      content: context.l10n.payed,
                                      onPressed: () {
                                        FunctionUtil.alertPopUpConfirm(
                                          onPressedConfirm: () {
                                            ref
                                                .read(ticketFormProvider)
                                                .confirmTicket(
                                                    ref, context, ticket);
                                            ref
                                                .read(ticketFormProvider)
                                                .sendEmailBookTicketSuccess(
                                                  ref: ref,
                                                  ticket: ticket,
                                                );
                                            Navigator.pop(context);
                                          },
                                          type: AlertType.warning,
                                          title: 'Xác nhận đã thanh toán',
                                          desc:
                                              'Khách hàng đã thanh toán cho vé này?',
                                        );
                                      },
                                    ),
                                    RoundedButtonWidget(
                                      content: context.l10n.cancel,
                                      onPressed: () {
                                        FunctionUtil.alertPopUpConfirm(
                                          onPressedConfirm: () {
                                            ref
                                                .read(ticketFormProvider)
                                                .cancelTicket(
                                                    ref, context, ticket);
                                            Navigator.pop(context);
                                          },
                                          type: AlertType.warning,
                                          title: 'Huỷ vé',
                                          desc: 'Xác nhận huỷ đặt vé?',
                                        );
                                      },
                                    )
                                  ],
                                ),
                              )
                          ],
                        ),
                      ),
                    ),
                  ],
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
    bool? isSpecial,
    bool? isSelectable,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: width * 0.3,
            child: Text(
              title,
              style: TextStyle(
                overflow: TextOverflow.clip,
                fontSize: 15,
                color: ColorName.textNormal,
                fontWeight: isSpecial ?? false ? FontWeight.w600 : null,
              ),
            ),
          ),
          Expanded(
            child: isSelectable ?? false
                ? SelectableTextCustom(
                    text: content,
                    style: TextStyle(
                      overflow: TextOverflow.clip,
                      fontSize: 15,
                      color: ColorName.textNormal,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                : Text(
                    content,
                    style: TextStyle(
                      overflow: TextOverflow.clip,
                      fontSize: 15,
                      color: ColorName.textNormal,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget rowStatusTicket({
    required BuildContext context,
    required String status,
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
              context.l10n.status,
              style: TextStyle(
                overflow: TextOverflow.clip,
                fontSize: 15,
                color: ColorName.textNormal,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color:
                  FunctionUtil.ticketStatusToColor(ticket.status ?? 'waitPay'),
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(15),
                right: Radius.circular(15),
              ),
            ),
            child: Text(
              status,
              style: TextStyle(
                overflow: TextOverflow.clip,
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
