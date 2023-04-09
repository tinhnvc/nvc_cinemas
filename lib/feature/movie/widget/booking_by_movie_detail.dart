import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/feature/movie/widget/date_booking_widget.dart';
import 'package:nvc_cinemas/feature/movie/widget/time_booking_widget.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:nvc_cinemas/l10n/l10n.dart';
import 'package:nvc_cinemas/shared/widget/arrow_back_title.dart';
import 'package:nvc_cinemas/shared/widget/rounded_button_widget.dart';
import 'package:nvc_cinemas/shared/widget/seat_title_widget.dart';
import 'package:nvc_cinemas/shared/widget/seat_type_widget.dart';
import 'package:nvc_cinemas/shared/widget/select/seat_widget.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class BookingByMovieDetail extends ConsumerWidget {
  const BookingByMovieDetail({Key? key}) : super(key: key);

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
                          '11:20 - 13/02/2023',
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
                                    price: '45.000đ',
                                    isNormal: true,
                                  ),
                                  SeatTypeWidget(
                                    color: Colors.grey,
                                    seatType: context.l10n.vipSeat,
                                    price: '60.000đ',
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
                          width: 210,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SeatWidget(
                              seatPosition: 'A1',
                              color: Colors.grey,
                              isNormal: true,
                            ),
                            SeatWidget(
                              seatPosition: 'A2',
                              color: Colors.grey,
                              isNormal: true,
                            ),
                            SeatWidget(
                              seatPosition: 'A3',
                              color: Colors.grey,
                              isNormal: true,
                            ),
                            SeatWidget(
                              seatPosition: 'A4',
                              color: Colors.grey,
                              isNormal: true,
                            ),
                            SeatWidget(
                              seatPosition: 'A5',
                              color: Colors.grey,
                              isNormal: true,
                            ),
                            SeatWidget(
                              seatPosition: 'A6',
                              color: Colors.grey,
                              isNormal: true,
                            ),
                            SeatWidget(
                              seatPosition: 'A7',
                              color: Colors.grey,
                              isNormal: true,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SeatWidget(
                              seatPosition: 'B1',
                              color: Colors.grey,
                              isNormal: true,
                            ),
                            SeatWidget(
                              seatPosition: 'B2',
                              color: Colors.grey,
                              isNormal: true,
                            ),
                            SeatWidget(
                              seatPosition: 'B3',
                              color: Colors.grey,
                              isNormal: true,
                            ),
                            SeatWidget(
                              seatPosition: 'B4',
                              color: Colors.grey,
                              isNormal: true,
                            ),
                            SeatWidget(
                              seatPosition: 'B5',
                              color: Colors.grey,
                              isNormal: true,
                            ),
                            SeatWidget(
                              seatPosition: 'B6',
                              color: Colors.grey,
                              isNormal: true,
                            ),
                            SeatWidget(
                              seatPosition: 'B7',
                              color: Colors.grey,
                              isNormal: true,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SeatWidget(
                              seatPosition: 'C1',
                              color: Colors.grey,
                              isNormal: false,
                            ),
                            SeatWidget(
                              seatPosition: 'C2',
                              color: Colors.grey,
                              isNormal: false,
                            ),
                            SeatWidget(
                              seatPosition: 'C3',
                              color: Colors.grey,
                              isNormal: false,
                            ),
                            SeatWidget(
                              seatPosition: 'C4',
                              color: Colors.grey,
                              isNormal: false,
                            ),
                            SeatWidget(
                              seatPosition: 'C5',
                              color: Colors.grey,
                              isNormal: false,
                            ),
                            SeatWidget(
                              seatPosition: 'C6',
                              color: Colors.grey,
                              isNormal: false,
                            ),
                            SeatWidget(
                              seatPosition: 'C7',
                              color: Colors.grey,
                              isNormal: false,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SeatWidget(
                              seatPosition: 'D1',
                              color: Colors.grey,
                              isNormal: false,
                            ),
                            SeatWidget(
                              seatPosition: 'D2',
                              color: Colors.grey,
                              isNormal: false,
                            ),
                            SeatWidget(
                              seatPosition: 'D3',
                              color: Colors.red,
                              isNormal: false,
                            ),
                            SeatWidget(
                              seatPosition: 'D4',
                              color: Colors.red,
                              isNormal: false,
                            ),
                            SeatWidget(
                              seatPosition: 'D5',
                              color: Colors.grey,
                              isNormal: false,
                            ),
                            SeatWidget(
                              seatPosition: 'D6',
                              color: Colors.grey,
                              isNormal: false,
                            ),
                            SeatWidget(
                              seatPosition: 'D7',
                              color: ColorName.primary,
                              isNormal: false,
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
        color: Colors.white,
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
                    Text(
                      'D7',
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
                      '60.000đ',
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
                  onPressed: () => Navigator.pushNamed(context, '/payment'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
