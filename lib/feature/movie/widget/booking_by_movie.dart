import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/feature/m_category/provider/category_provider.dart';
import 'package:nvc_cinemas/feature/m_movie/provider/time_provider.dart';
import 'package:nvc_cinemas/feature/movie/model/movie_model.dart';
import 'package:nvc_cinemas/feature/movie/provider/day_of_week_provder.dart';
import 'package:nvc_cinemas/feature/movie/widget/date_booking_widget.dart';
import 'package:nvc_cinemas/feature/movie/widget/time_booking_widget.dart';
import 'package:nvc_cinemas/gen/assets.gen.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:nvc_cinemas/l10n/l10n.dart';
import 'package:nvc_cinemas/shared/provider/util_provider.dart';
import 'package:nvc_cinemas/shared/service/date_service.dart';
import 'package:nvc_cinemas/shared/util/init_util.dart';
import 'package:nvc_cinemas/shared/widget/arrow_back_title.dart';
import 'package:nvc_cinemas/shared/widget/rounded_button_widget.dart';

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

    final category =
        ref.read(categoriesProvider.notifier).getById(movie.category!);
    final weekMap = ref.watch(dayOfWeekProvider);
    final timesShowByDay =
        ref.read(timesProvider.notifier).getByDay(ref: ref, movieId: movie.id!);

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
                              ? '${category.categoryName} | '
                                  '${movie.duration} ${context.l10n.minutes}'
                              : '${category.categoryNameEn} | '
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
                          height: 70,
                          child: ListView(
                            physics: AlwaysScrollableScrollPhysics(
                                parent: BouncingScrollPhysics()),
                            scrollDirection: Axis.horizontal,
                            children: weekMap
                                .map(
                                  (e) => GestureDetector(
                                    onTap: () {
                                      ref
                                          .read(dayOfWeekProvider.notifier)
                                          .onceSelect(e.id!);
                                    },
                                    child: DateBookingWidget(
                                      date: DateTime.fromMillisecondsSinceEpoch(
                                              e.day!)
                                          .day
                                          .toString(),
                                      dayOfWeek: DateTime
                                                      .fromMillisecondsSinceEpoch(
                                                          e.day!)
                                                  .day ==
                                              DateTime.now().day
                                          ? '${e.dayOfWeek}'
                                          : '0${DateTime.fromMillisecondsSinceEpoch(e.day!).month.toString()} - ${e.dayOfWeek}',
                                      isSelect: e.isSelected ?? false,
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        if (timesShowByDay.isNotEmpty)
                          Row(
                            children: [
                              Text(
                                movie.dimension == '2D'
                                    ? context.l10n.twoDimensionalSubtitle
                                    : context.l10n.threeDimensionalSubtitle,
                                style: TextStyle(
                                  color: ColorName.btnText,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        if (timesShowByDay.isNotEmpty)
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
                            children: timesShowByDay.isNotEmpty
                                ? timesShowByDay.map((e) {
                                    return GestureDetector(
                                        onTap: () {
                                          InitUtil.initBookingByMovieDetail(
                                            ref: ref,
                                            time: e,
                                          );
                                          Navigator.pushNamed(
                                            context,
                                            '/booking-by-movie-detail',
                                            arguments: {
                                              'movie': movie,
                                              'time': e,
                                            },
                                          );
                                        },
                                        child: TimeBookingWidget(time: e));
                                  }).toList()
                                : [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          context.l10n.noShowtime,
                                          style: TextStyle(
                                            color: ColorName.btnText,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
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
