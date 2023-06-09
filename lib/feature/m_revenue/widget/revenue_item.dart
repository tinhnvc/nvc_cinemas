import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/feature/movie/model/movie_model.dart';
import 'package:nvc_cinemas/feature/ticket/provider/ticket_provider.dart';
import 'package:nvc_cinemas/gen/assets.gen.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:nvc_cinemas/l10n/l10n.dart';
import 'package:nvc_cinemas/shared/provider/util_provider.dart';
import 'package:nvc_cinemas/shared/util/format_support.dart';

class RevenueItem extends ConsumerWidget {
  const RevenueItem({required this.movie, Key? key}) : super(key: key);
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
    final ticketAmount = ref
        .read(ticketsProvider.notifier)
        .ticketAmountByMovieId(ref, movie.id!);
    final total =
        ref.read(ticketsProvider.notifier).totalByMovieId(ref, movie.id!);

    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        '/revenue-detail',
        arguments: movie,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: ColorName.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              height: 120,
              width: 100,
              margin: const EdgeInsets.only(right: 15),
              decoration: BoxDecoration(
                color: Colors.white,
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
                        width: width * 0.5,
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
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${context.l10n.ticketAmount}: $ticketAmount',
                    style: TextStyle(
                      fontSize: 15,
                      color: ColorName.textNormal,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                        '${context.l10n.totalRevenue}: ',
                        style: TextStyle(
                          fontSize: 15,
                          color: ColorName.textNormal,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        total != 0
                            ? '${FormatSupport.toMoney(total)}đ'
                            : 'Chưa có doanh thu',
                        style: TextStyle(
                          fontSize: 15,
                          color: ColorName.textNormal,
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
    );
  }
}
