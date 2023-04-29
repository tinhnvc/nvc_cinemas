import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/feature/auth/provider/users_provider.dart';
import 'package:nvc_cinemas/feature/m_movie/provider/m_movie_provider.dart';
import 'package:nvc_cinemas/feature/m_movie/provider/time_provider.dart';
import 'package:nvc_cinemas/feature/m_room/provider/m_room_provider.dart';
import 'package:nvc_cinemas/feature/m_room/provider/m_seat_provider.dart';
import 'package:nvc_cinemas/feature/ticket/model/ticket_model.dart';
import 'package:nvc_cinemas/feature/ticket/provider/ticket_provider.dart';
import 'package:nvc_cinemas/gen/assets.gen.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:nvc_cinemas/l10n/l10n.dart';
import 'package:nvc_cinemas/shared/provider/util_provider.dart';
import 'package:nvc_cinemas/shared/util/format_support.dart';
import 'package:nvc_cinemas/shared/util/function_ulti.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class MTicketItem extends ConsumerWidget {
  const MTicketItem({required this.ticket, Key? key}) : super(key: key);
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

    return GestureDetector(
      onTap: () =>
          Navigator.pushNamed(context, '/ticket-detail', arguments: ticket),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: ColorName.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              width: 100,
              margin: const EdgeInsets.only(right: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
              child: movie.image != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.file(
                        File(movie.image!),
                        fit: BoxFit.cover,
                      ),
                    )
                  : Assets.images.logoPng
                      .image(width: 100, fit: BoxFit.contain),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: width * 0.4,
                        child: Text(
                          isVietnamese
                              ? movie.movieNameVi ?? context.l10n.notUpdated
                              : movie.movieNameEn ?? context.l10n.notUpdated,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            color: ColorName.textNormal,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (ticket.status == 'waitPay' ||
                              ticket.status == 'waitConfirm')
                            GestureDetector(
                              onTap: () {
                                FunctionUtil.alertPopUpConfirm(
                                  onPressedConfirm: () {
                                    ref
                                        .read(ticketFormProvider)
                                        .confirmTicket(ref, context, ticket);
                                    ref
                                        .read(ticketFormProvider)
                                        .sendEmailBookTicketSuccess(
                                          ref: ref,
                                          ticket: ticket,
                                        );
                                  },
                                  type: AlertType.warning,
                                  title: 'Xác nhận đã thanh toán',
                                  desc: 'Khách hàng đã thanh toán cho vé này?',
                                );
                              },
                              child: Icon(
                                Icons.done_sharp,
                                size: 25,
                                color: ColorName.primary,
                              ),
                            ),
                          const SizedBox(width: 10),
                          if (ticket.status == 'waitPay' ||
                              ticket.status == 'waitConfirm')
                            GestureDetector(
                              onTap: () {
                                FunctionUtil.alertPopUpConfirm(
                                  onPressedConfirm: () {
                                    ref
                                        .read(ticketFormProvider)
                                        .cancelTicket(ref, context, ticket);
                                  },
                                  type: AlertType.warning,
                                  title: 'Huỷ vé',
                                  desc: 'Xác nhận huỷ đặt vé?',
                                );
                              },
                              child: Icon(
                                Icons.cancel_outlined,
                                size: 25,
                                color: ColorName.primary,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Email: ${user.email}',
                    style: TextStyle(
                      fontSize: 15,
                      color: ColorName.textNormal,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${context.l10n.dateShow}: ${FormatSupport.toDateTimeNonSecond(time.from!)}',
                    style: TextStyle(
                      fontSize: 15,
                      color: ColorName.textNormal,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                        '${context.l10n.pay}: ',
                        style: TextStyle(
                          fontSize: 15,
                          color: ColorName.textNormal,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '${FormatSupport.toMoney(ticket.totalPrice ?? 45000)}đ',
                        style: TextStyle(
                          fontSize: 15,
                          color: ColorName.textNormal,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                        '${context.l10n.status}: ',
                        style: TextStyle(
                          fontSize: 15,
                          color: ColorName.textNormal,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        FunctionUtil.ticketStatusToContent(
                            context, ticket.status ?? 'waitPay'),
                        style: TextStyle(
                          fontSize: 15,
                          color: FunctionUtil.ticketStatusToColor(
                              ticket.status ?? 'waitPay'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${context.l10n.createAt}: ${FormatSupport.toDateTimeNonSecond(ticket.createAt!)}',
                    style: TextStyle(
                      fontSize: 15,
                      color: ColorName.textNormal,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
