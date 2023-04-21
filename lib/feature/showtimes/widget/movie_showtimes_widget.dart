import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/feature/m_category/provider/category_provider.dart';
import 'package:nvc_cinemas/feature/m_movie/provider/time_provider.dart';
import 'package:nvc_cinemas/feature/m_room/provider/m_seat_provider.dart';
import 'package:nvc_cinemas/feature/movie/model/movie_model.dart';
import 'package:nvc_cinemas/feature/movie/provider/day_of_week_provider.dart';
import 'package:nvc_cinemas/feature/movie/widget/time_booking_widget.dart';
import 'package:nvc_cinemas/gen/assets.gen.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:nvc_cinemas/l10n/l10n.dart';
import 'package:nvc_cinemas/shared/provider/util_provider.dart';
import 'package:nvc_cinemas/shared/util/init_util.dart';

class MovieShowtimesWidget extends ConsumerWidget {
  const MovieShowtimesWidget({required this.movie, Key? key}) : super(key: key);
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
    final weekMap = ref.watch(dayOfWeekProvider);
    final timesShowByDay =
        ref.read(timesProvider.notifier).getByDay(ref: ref, movieId: movie.id!);
    final emptySeats = ref
        .read(seatsProvider.notifier)
        .getSeatEmptyAmount(ref, timesShowByDay[0]);
    final category =
        ref.read(categoriesProvider.notifier).getById(movie.category!);

    return Container(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                height: 150,
                width: 100,
                margin: const EdgeInsets.only(right: 15),
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
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isVietnamese
                          ? movie.movieNameVi ?? context.l10n.notUpdated
                          : movie.movieNameEn ?? context.l10n.notUpdated,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 17,
                        color: ColorName.textNormal,
                        fontWeight: FontWeight.w600,
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
                        fontSize: 15,
                        color: ColorName.textNormal,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const SizedBox(
            height: 10,
          ),
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
              height: 10,
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
                        mainAxisAlignment: MainAxisAlignment.center,
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
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
