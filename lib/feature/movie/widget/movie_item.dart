import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/feature/movie/model/movie_model.dart';
import 'package:nvc_cinemas/gen/assets.gen.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:nvc_cinemas/l10n/l10n.dart';
import 'package:nvc_cinemas/shared/provider/util_provider.dart';
import 'package:nvc_cinemas/shared/util/init_util.dart';

class MovieItem extends ConsumerWidget {
  const MovieItem({required this.movie, Key? key}) : super(key: key);
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

    return GestureDetector(
      onTap: () {
        InitUtil.initBookingByMovie(ref: ref);
        Navigator.pushNamed(context, '/booking-by-movie', arguments: movie);
      },
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 200,
              width: 300,
              decoration: BoxDecoration(
                color: Colors.white54,
                borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
              child: movie.image != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: movie.image!.contains('/m/')
                          ? Image.asset(
                              movie.image!,
                              fit: BoxFit.cover,
                            )
                          : Image.file(
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
            Text(
              '${movie.duration} ${context.l10n.minutes.toLowerCase()}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 15,
                color: ColorName.textNormal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
