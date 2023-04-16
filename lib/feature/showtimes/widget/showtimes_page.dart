import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/feature/movie/widget/date_booking_widget.dart';
import 'package:nvc_cinemas/feature/movie/widget/time_booking_widget.dart';
import 'package:nvc_cinemas/feature/showtimes/widget/movie_showtimes_widget.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:nvc_cinemas/l10n/l10n.dart';
import 'package:nvc_cinemas/shared/provider/user_provider.dart';
import 'package:nvc_cinemas/shared/widget/rounded_button_widget.dart';

class ShowtimesPage extends ConsumerWidget {
  const ShowtimesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    final inset = MediaQuery.of(context).viewInsets;
    final height = size.height - (padding.top + padding.bottom + inset.bottom);
    final width = size.width - (padding.left + padding.right + inset.right);
    final ratio = height / size.width;
    final user = ref.watch(userProvider);

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
                    image: new ExactAssetImage('assets/images/logo-png.png'),
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
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const SizedBox(height: 20),
                        Text(
                          context.l10n.bookingByTime,
                          style: TextStyle(
                            color: ColorName.btnText,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: width,
                          height: 60,
                          child: ListView(
                            physics: AlwaysScrollableScrollPhysics(
                                parent: BouncingScrollPhysics()),
                            scrollDirection: Axis.horizontal,
                            children: [
                              DateBookingWidget(
                                date: '13',
                                dayOfWeek: 'Hôm nay',
                                isSelect: true,
                              ),
                              DateBookingWidget(
                                date: '14',
                                dayOfWeek: '02 - T3',
                                isSelect: false,
                              ),
                              DateBookingWidget(
                                date: '15',
                                dayOfWeek: '02 - T4',
                                isSelect: false,
                              ),
                              DateBookingWidget(
                                date: '16',
                                dayOfWeek: '02 - T5',
                                isSelect: false,
                              ),
                              DateBookingWidget(
                                date: '17',
                                dayOfWeek: '02 - T6',
                                isSelect: false,
                              ),
                              DateBookingWidget(
                                date: '18',
                                dayOfWeek: '02 - T7',
                                isSelect: false,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        MovieShowtimesWidget(),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              context.l10n.twoDimensionalSubtitle,
                              style: TextStyle(
                                color: ColorName.btnText,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: width,
                          height: 60,
                          child: ListView(
                            physics: AlwaysScrollableScrollPhysics(
                                parent: BouncingScrollPhysics()),
                            scrollDirection: Axis.horizontal,
                            children: [
                              // GestureDetector(
                              //   onTap: () => Navigator.pushNamed(
                              //       context, '/booking-by-movie-detail'),
                              //   child: TimeBookingWidget(
                              //     time: '11:20',
                              //     seat:
                              //         '25 ${context.l10n.empty.toLowerCase()}',
                              //   ),
                              // ),
                              // TimeBookingWidget(
                              //   time: '14:10',
                              //   seat: '30 ${context.l10n.empty.toLowerCase()}',
                              // ),
                              // TimeBookingWidget(
                              //   time: '21:00',
                              //   seat: '12 ${context.l10n.empty.toLowerCase()}',
                              // ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        MovieShowtimesWidget(),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              context.l10n.twoDimensionalSubtitle,
                              style: TextStyle(
                                color: ColorName.btnText,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: width,
                          height: 60,
                          child: ListView(
                            physics: AlwaysScrollableScrollPhysics(
                                parent: BouncingScrollPhysics()),
                            scrollDirection: Axis.horizontal,
                            children: [
                              // GestureDetector(
                              //   onTap: () => Navigator.pushNamed(
                              //       context, '/booking-by-movie-detail'),
                              //   child: TimeBookingWidget(
                              //     time: '11:20',
                              //     seat:
                              //         '25 ${context.l10n.empty.toLowerCase()}',
                              //   ),
                              // ),
                              // TimeBookingWidget(
                              //   time: '14:10',
                              //   seat: '30 ${context.l10n.empty.toLowerCase()}',
                              // ),
                              // TimeBookingWidget(
                              //   time: '21:00',
                              //   seat: '12 ${context.l10n.empty.toLowerCase()}',
                              // ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        MovieShowtimesWidget(),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              context.l10n.twoDimensionalSubtitle,
                              style: TextStyle(
                                color: ColorName.btnText,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: width,
                          height: 60,
                          child: ListView(
                            physics: AlwaysScrollableScrollPhysics(
                                parent: BouncingScrollPhysics()),
                            scrollDirection: Axis.horizontal,
                            children: [
                              // GestureDetector(
                              //   onTap: () => Navigator.pushNamed(
                              //       context, '/booking-by-movie-detail'),
                              //   child: TimeBookingWidget(
                              //     time: '11:20',
                              //     seat:
                              //         '25 ${context.l10n.empty.toLowerCase()}',
                              //   ),
                              // ),
                              // TimeBookingWidget(
                              //   time: '14:10',
                              //   seat: '30 ${context.l10n.empty.toLowerCase()}',
                              // ),
                              // TimeBookingWidget(
                              //   time: '21:00',
                              //   seat: '12 ${context.l10n.empty.toLowerCase()}',
                              // ),
                            ],
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
}
