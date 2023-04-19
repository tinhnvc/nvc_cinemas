import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/feature/m_category/provider/category_provider.dart';
import 'package:nvc_cinemas/feature/movie/model/movie_model.dart';
import 'package:nvc_cinemas/feature/movie/provider/movie_rating_provider.dart';
import 'package:nvc_cinemas/feature/movie/widget/rate_movie_widget.dart';
import 'package:nvc_cinemas/gen/assets.gen.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:nvc_cinemas/l10n/l10n.dart';
import 'package:nvc_cinemas/shared/provider/user_provider.dart';
import 'package:nvc_cinemas/shared/provider/util_provider.dart';
import 'package:nvc_cinemas/shared/util/format_support.dart';
import 'package:nvc_cinemas/shared/util/init_util.dart';
import 'package:nvc_cinemas/shared/widget/arrow_back_title.dart';
import 'package:nvc_cinemas/shared/widget/call_modal_sheet.dart';
import 'package:nvc_cinemas/shared/widget/highlight_card.dart';
import 'package:nvc_cinemas/shared/widget/primary_button_widget.dart';

class MovieDetail extends ConsumerWidget {
  const MovieDetail({required this.movie, Key? key}) : super(key: key);
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
    ref.watch(movieRatingsProvider);
    final category =
    ref.read(categoriesProvider.notifier).getById(movie.category!);
    final comments =
        ref.read(movieRatingsProvider.notifier).getByMovieId(movie.id!);
    final sumRate = ref.read(movieRatingsProvider.notifier).sumRate(movie.id!);
    final isComment =
        ref.read(movieRatingsProvider.notifier).isComment(ref, movie.id!);

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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        ArrowBackTitle(
                          title: context.l10n.filmDetail,
                          textSize: 19,
                          onPressed: () => Navigator.pop(context),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              height: 220,
                              width: 150,
                              margin: const EdgeInsets.only(right: 15),
                              decoration: BoxDecoration(
                                color: Colors.white54,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6)),
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
                                        ? movie.movieNameVi ??
                                            context.l10n.notUpdated
                                        : movie.movieNameEn ??
                                            context.l10n.notUpdated,
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
                                  HighlightCard(
                                    widget: Text(
                                      movie.type ?? context.l10n.notUpdated,
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: ColorName.textNormal,
                                      ),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 3),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        rowInformation(
                          title: context.l10n.director,
                          content: movie.director ?? context.l10n.notUpdated,
                          width: width,
                        ),
                        rowInformation(
                          title: context.l10n.cast,
                          content:
                              (movie.actor != null && movie.actor!.isNotEmpty)
                                  ? movie.actor!
                                  : context.l10n.notUpdated,
                          width: width,
                        ),
                        rowInformation(
                          title: context.l10n.categories,
                          content: isVietnamese
                              ? '${category.categoryName}'
                              : '${category.categoryNameEn}',
                          width: width,
                        ),
                        rowInformation(
                          title: context.l10n.runTime,
                          content: '${movie.duration} ${context.l10n.minutes}',
                          width: width,
                        ),
                        rowInformation(
                          title: context.l10n.releaseDate,
                          content:
                              FormatSupport.toDateTimeNonHour(movie.startTime!),
                          width: width,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          movie.description ?? context.l10n.notUpdated,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: 15,
                            color: ColorName.textNormal,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              size: 19,
                              color: ColorName.btnText,
                            ),
                            Text(
                              ' ${sumRate}',
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontSize: 15,
                                color: ColorName.textNormal,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Icon(
                              Icons.horizontal_rule,
                              size: 15,
                              color: ColorName.btnText,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Text(
                              '${comments.length} ${context.l10n.rateTimes}',
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontSize: 15,
                                color: ColorName.textNormal,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 15),
                          child: const Divider(
                            color: ColorName.btnText,
                            height: 2,
                          ),
                        ),
                        comments.isNotEmpty
                            ? Column(
                                children: comments
                                    .map(
                                      (e) => RateMovieWidget(
                                        movieRating: e,
                                      ),
                                    )
                                    .toList(),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    context.l10n.noComment,
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: ColorName.textNormal,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            PrimaryButtonWidget(
                              content: context.l10n.comment,
                              width: 120,
                              active: !isComment,
                              onPressed: isComment
                                  ? () {}
                                  : () {
                                      InitUtil.initComment(
                                        ref: ref,
                                        userId: ref.watch(userProvider).userId!,
                                        movieId: movie.id!,
                                      );
                                      CallModalSheet.commentMovie(
                                          context, movie);
                                    },
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
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

  Widget rowInformation({
    required String title,
    required String content,
    required double width,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: width * 0.3,
            child: Text(
              title,
              style: TextStyle(
                overflow: TextOverflow.clip,
                fontSize: 15,
                color: ColorName.textNormal,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            width: width * 0.6,
            child: Text(
              content,
              style: TextStyle(
                overflow: TextOverflow.clip,
                fontSize: 15,
                color: ColorName.textNormal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
