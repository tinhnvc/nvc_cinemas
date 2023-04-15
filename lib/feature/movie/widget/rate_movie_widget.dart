import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/feature/auth/provider/users_provider.dart';
import 'package:nvc_cinemas/feature/movie/model/movie_rating_model.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:nvc_cinemas/l10n/l10n.dart';
import 'package:nvc_cinemas/shared/util/format_support.dart';

class RateMovieWidget extends ConsumerWidget {
  const RateMovieWidget({
    required this.movieRating,
    Key? key,
  }) : super(key: key);

  final MovieRatingModel movieRating;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userComment =
        ref.read(usersProvider.notifier).getById(movieRating.userId!);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: ColorName.primary.withOpacity(0.6),
            radius: 20,
            child: Icon(
              Icons.person,
              color: ColorName.textNormal,
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${userComment.fullName}  -  ★ ${movieRating.star}',
                        style: TextStyle(
                          color: ColorName.btnText,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        FormatSupport.toDateTimeNonSecond(
                          movieRating.createAt!,
                        ),
                        style: TextStyle(
                          color: ColorName.btnText,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    movieRating.comment ?? context.l10n.notUpdated,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: ColorName.btnText,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
