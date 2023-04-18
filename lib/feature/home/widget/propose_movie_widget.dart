import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/feature/movie/model/movie_model.dart';
import 'package:nvc_cinemas/feature/movie/provider/day_of_week_provder.dart';
import 'package:nvc_cinemas/feature/movie/provider/movie_rating_provider.dart';
import 'package:nvc_cinemas/gen/assets.gen.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:nvc_cinemas/l10n/l10n.dart';
import 'package:nvc_cinemas/shared/provider/util_provider.dart';
import 'package:nvc_cinemas/shared/util/format_support.dart';
import 'package:nvc_cinemas/shared/util/init_util.dart';

class ProposeMovieWidget extends ConsumerWidget {
  const ProposeMovieWidget({required this.movie, Key? key}) : super(key: key);
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
    final sumRate = ref.read(movieRatingsProvider.notifier).sumRate(movie.id!);

    return GestureDetector(
      onTap: () {
        InitUtil.initBookingByMovie(ref: ref);
        Navigator.pushNamed(context, '/booking-by-movie', arguments: movie);
      },
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 220,
              width: 200,
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
            const SizedBox(
              height: 5,
            ),
            Text(
              isVietnamese
                  ? movie.movieNameVi ?? context.l10n.notUpdated
                  : movie.movieNameEn ?? context.l10n.notUpdated,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 15,
                color: ColorName.textNormal,
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  FormatSupport.toDateTimeNonHour(movie.startTime!),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 15,
                    color: ColorName.textNormal,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      size: 18,
                      color: ColorName.textNormal,
                    ),
                    Text(
                      ' ${sumRate}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 15,
                        color: ColorName.textNormal,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
