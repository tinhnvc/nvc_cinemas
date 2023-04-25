import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/feature/m_category/provider/category_provider.dart';
import 'package:nvc_cinemas/feature/m_movie/provider/m_movie_provider.dart';
import 'package:nvc_cinemas/feature/movie/model/movie_model.dart';
import 'package:nvc_cinemas/gen/assets.gen.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:nvc_cinemas/l10n/l10n.dart';
import 'package:nvc_cinemas/shared/provider/util_provider.dart';
import 'package:nvc_cinemas/shared/util/format_support.dart';
import 'package:nvc_cinemas/shared/util/function_ulti.dart';
import 'package:nvc_cinemas/shared/util/init_util.dart';

class MMovieItem extends ConsumerWidget {
  const MMovieItem({required this.movie, Key? key}) : super(key: key);
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

    return Container(
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
                : Assets.images.logoPng.image(width: 100, fit: BoxFit.contain),
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
                      width: width * 0.3,
                      child: Text(
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
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () =>
                              Navigator.pushNamed(context, '/add-showtimes'),
                          child: Icon(
                            Icons.date_range_rounded,
                            size: 25,
                            color: ColorName.primary,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            InitUtil.initEditMovie(
                              ref: ref,
                              context: context,
                              movie: movie,
                            );
                            Navigator.pushNamed(
                              context,
                              '/edit-movie',
                              arguments: movie,
                            );
                          },
                          child: Icon(
                            Icons.edit_note,
                            size: 25,
                            color: ColorName.primary,
                          ),
                        ),
                        Transform.scale(
                          scale: 0.7,
                          alignment: Alignment.topCenter,
                          child: CupertinoSwitch(
                            value: movie.active ?? false,
                            onChanged: (bool value) {
                              if (!value) {
                                FunctionUtil.alertPopUpConfirmWithContent(
                                    onPressedConfirm: () {
                                      ref
                                          .read(moviesProvider.notifier)
                                          .switchActive(movie.id!, value);
                                    },
                                    content:
                                        'Phim\nPhim sau khi đóng sẽ không xuất hiện trên danh sách phim, khách hàng không thể đặt vé');
                              } else {
                                ref
                                    .read(moviesProvider.notifier)
                                    .switchActive(movie.id!, value);
                              }
                            },
                            activeColor: ColorName.primary,
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
                const SizedBox(
                  height: 5,
                ),
                Text(
                  '${context.l10n.releaseShow}: ${FormatSupport.toDateTimeNonHour(movie.startTime!)}',
                  style: TextStyle(
                    fontSize: 15,
                    color: ColorName.textNormal,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  '${context.l10n.createAt}: ${FormatSupport.toDateTimeNonSecond(movie.createAt!)}',
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
    );
  }
}
