import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/feature/movie/model/movie_model.dart';
import 'package:nvc_cinemas/feature/movie/widget/date_booking_widget.dart';
import 'package:nvc_cinemas/feature/movie/widget/time_booking_widget.dart';
import 'package:nvc_cinemas/gen/assets.gen.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:nvc_cinemas/l10n/l10n.dart';
import 'package:nvc_cinemas/shared/provider/util_provider.dart';
import 'package:nvc_cinemas/shared/service/date_service.dart';
import 'package:nvc_cinemas/shared/widget/arrow_back_title.dart';
import 'package:nvc_cinemas/shared/widget/rounded_button_widget.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class BookingByMovie extends ConsumerWidget {
  const BookingByMovie({required this.movie, Key? key}) : super(key: key);
  final MovieModel movie;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    final inset = MediaQuery.of(context).viewInsets;
    final height = size.height - (padding.top + padding.bottom + inset.bottom);
    final width = size.width - (padding.left + padding.right + inset.right);
    final ratio = height / size.width;
    final isVietnamese = ref.watch(languageProvider) == 'vi';

    final weekMap = DateService.dateRangeInWeek(ref, context);

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
                height: height * 0.8,
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
                      color: ColorName.pageBackground.withOpacity(0.8),
                    ),
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
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
                        Container(
                          height: 180,
                          width: 120,
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: Colors.white54,
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
                        GestureDetector(
                          onTap: () {
                            DateService.dateRangeInWeek(ref, context);
                          },
                          child: Text(
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
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          isVietnamese
                              ? '${movie.category!.categoryName} | '
                                  '${movie.duration} ${context.l10n.minutes}'
                              : '${movie.category!.categoryNameEn} | '
                                  '${movie.duration} ${context.l10n.minutes}',
                          style: TextStyle(
                            color: ColorName.btnText,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        RoundedButtonWidget(
                          content: context.l10n.filmDetail,
                          onPressed: () => Navigator.pushNamed(
                            context,
                            '/movie-detail',
                            arguments: movie,
                          ),
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
                            children: weekMap
                                .map(
                                  (e) => DateBookingWidget(
                                    date: e['day'].day.toString(),
                                    dayOfWeek: e['day'].day ==
                                            DateTime.now().day
                                        ? '${e['dayOfWeek']}'
                                        : '0${e['day'].month.toString()} - ${e['dayOfWeek']}',
                                    isSelect:
                                        e['day'].day == DateTime.now().day,
                                  ),
                                )
                                .toList(),
                            //
                            // children: [
                            //   DateBookingWidget(
                            //     date: '13',
                            //     dayOfWeek: 'Hôm nay',
                            //     isSelect: true,
                            //   ),
                            //   DateBookingWidget(
                            //     date: '14',
                            //     dayOfWeek: '02 - T3',
                            //     isSelect: false,
                            //   ),
                            //   DateBookingWidget(
                            //     date: '15',
                            //     dayOfWeek: '02 - T4',
                            //     isSelect: false,
                            //   ),
                            //   DateBookingWidget(
                            //     date: '16',
                            //     dayOfWeek: '02 - T5',
                            //     isSelect: false,
                            //   ),
                            //   DateBookingWidget(
                            //     date: '17',
                            //     dayOfWeek: '02 - T6',
                            //     isSelect: false,
                            //   ),
                            //   DateBookingWidget(
                            //     date: '18',
                            //     dayOfWeek: '02 - T7',
                            //     isSelect: false,
                            //   ),
                            // ],
                          ),
                        ),
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
                              GestureDetector(
                                onTap: () => Navigator.pushNamed(
                                    context, '/booking-by-movie-detail'),
                                child: TimeBookingWidget(
                                  time: '11:20',
                                  seat:
                                      '25 ${context.l10n.empty.toLowerCase()}',
                                ),
                              ),
                              TimeBookingWidget(
                                time: '14:10',
                                seat: '30 ${context.l10n.empty.toLowerCase()}',
                              ),
                              TimeBookingWidget(
                                time: '21:00',
                                seat: '12 ${context.l10n.empty.toLowerCase()}',
                              ),
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
