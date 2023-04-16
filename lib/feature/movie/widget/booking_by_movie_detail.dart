import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/feature/m_movie/model/time_model.dart';
import 'package:nvc_cinemas/feature/m_room/model/seat_model.dart';
import 'package:nvc_cinemas/feature/m_room/provider/m_room_provider.dart';
import 'package:nvc_cinemas/feature/m_room/provider/m_seat_provider.dart';
import 'package:nvc_cinemas/feature/m_seat/provider/seat_type_provider.dart';
import 'package:nvc_cinemas/feature/movie/model/movie_model.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:nvc_cinemas/l10n/l10n.dart';
import 'package:nvc_cinemas/shared/provider/util_provider.dart';
import 'package:nvc_cinemas/shared/util/format_support.dart';
import 'package:nvc_cinemas/shared/widget/arrow_back_title.dart';
import 'package:nvc_cinemas/shared/widget/rounded_button_widget.dart';
import 'package:nvc_cinemas/shared/widget/seat_title_widget.dart';
import 'package:nvc_cinemas/shared/widget/seat_type_widget.dart';
import 'package:nvc_cinemas/shared/widget/select/seat_widget.dart';
import 'package:nvc_cinemas/shared/widget/snack_bar_support.dart';

class BookingByMovieDetail extends ConsumerWidget {
  const BookingByMovieDetail({
    required this.args,
    Key? key,
  }) : super(key: key);
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
    final room = ref.read(roomsProvider.notifier).getById(time.roomId!);
    final seatTypes = ref.watch(seatTypesProvider);
    // final seats = ref.read(seatsProvider.notifier).getByRoomId(room.id!);
    final allSeats = ref.watch(seatsProvider);
    final priceNormal = ref.read(seatTypesProvider.notifier).getPriceByIndex(0);
    final priceVip = ref.read(seatTypesProvider.notifier).getPriceByIndex(1);
    final row = int.parse(room.size!.split(' x ')[0]);
    final col = int.parse(room.size!.split(' x ')[1]);
    var rowList = [];
    var colList = [];
    var indexList = [];
    for (int i = 0; i < row; i++) {
      rowList.add(i + 1);
    }
    for (int i = 0; i < col; i++) {
      colList.add(i + 1);
    }
    for (int i = 0; i < row * col; i++) {
      indexList.add(i);
    }
    final seats = <SeatModel>[];
    if (allSeats.isNotEmpty) {
      for (final item in allSeats) {
        if (item.roomId == room.id) {
          seats.add(item);
        }
      }
    }
    seats.sort((a, b) => a.position!.compareTo(b.position!));
    final seatSelected = ref.read(seatsProvider.notifier).getSelected();

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
                    image: new ExactAssetImage('assets/images/book-ticket.png'),
                    fit: BoxFit.contain,
                  ),
                ),
                child: BackdropFilter(
                  filter: new ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                  child: Container(
                    decoration: new BoxDecoration(
                      color: ColorName.pageBackground.withOpacity(0.7),
                    ),
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        ArrowBackTitle(
                          title: context.l10n.bookingByMovie,
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
                          '${context.l10n.twoDimensionalSubtitle} | '
                          '${movie.duration} ${context.l10n.minutes.toLowerCase()} | '
                          '${FormatSupport.toDateTimeNonSecond(time.from!)}',
                          style: TextStyle(
                            color: ColorName.btnText,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SeatTitleWidget(
                                    color: Colors.grey,
                                    seatTitle: context.l10n.emptySeat,
                                  ),
                                  SeatTitleWidget(
                                    color: Colors.red,
                                    seatTitle: context.l10n.soldSeat,
                                  ),
                                  SeatTitleWidget(
                                    color: ColorName.primary,
                                    seatTitle: context.l10n.selectingSeat,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SeatTypeWidget(
                                    color: Colors.grey,
                                    seatType: context.l10n.normalSeat,
                                    price: priceNormal,
                                    isNormal: true,
                                  ),
                                  SeatTypeWidget(
                                    color: Colors.grey,
                                    seatType: context.l10n.vipSeat,
                                    price: priceVip,
                                    isNormal: false,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: const Divider(
                            color: ColorName.btnText,
                          ),
                        ),
                        Text(
                          context.l10n.screen.toUpperCase(),
                          style: TextStyle(
                            color: ColorName.btnText,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 170,
                          height: 10,
                          decoration: BoxDecoration(
                            color: ColorName.btnText,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        // Column(
                        //   children: rowList.map(
                        //     (eRow) {
                        //       return Row(
                        //         mainAxisAlignment: MainAxisAlignment.center,
                        //         children: colList
                        //             .map((eCol) => SeatWidget(
                        //                   seat: seats[eRow * eCol - 1],
                        //                 ))
                        //             .toList(),
                        //       );
                        //     },
                        //   ).toList(),
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 30),
                              height: 300,
                              width: 330,
                              child: GridView.count(
                                crossAxisCount: col,
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 5,
                                children: indexList
                                    .map((e) => GestureDetector(
                                          onTap: () {
                                            ref
                                                .read(seatsProvider.notifier)
                                                .onceSelect(seats[e].id!);
                                          },
                                          child: SeatWidget(
                                            seat: seats[e],
                                          ),
                                        ))
                                    .toList(),
                              ),
                            ),
                          ],
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
      bottomSheet: Container(
        color: ColorName.primary.withOpacity(0.1),
        height: 70,
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 55,
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(width: 1, color: ColorName.textNormal),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      context.l10n.selectedSeat,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF4B5574),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (seatSelected.id != null)
                      Text(
                        seatSelected.position ?? 'A1',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Color(0xFF4B5574),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 55,
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(width: 1, color: ColorName.textNormal),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      context.l10n.total,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF4B5574),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      seatSelected.seatTypeId != null
                          ? ref
                              .read(seatTypesProvider.notifier)
                              .getPriceById(seatSelected.seatTypeId!)
                          : '0đ',
                      style: const TextStyle(
                        fontSize: 20,
                        color: ColorName.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: RoundedButtonWidget(
                  content: context.l10n.next,
                  fontSize: 18,
                  onPressed: seatSelected.id != null
                      ? () => Navigator.pushNamed(
                            context,
                            '/payment',
                            arguments: {
                              'movie': movie,
                              'time': time,
                              'room': room,
                              'seat': seatSelected,
                            },
                          )
                      : () {
                          SnackBarSupport.requiredSelectSeat(
                            context: context,
                            hideAction: true,
                          );
                        },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
