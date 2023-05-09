import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/feature/m_category/provider/category_provider.dart';
import 'package:nvc_cinemas/feature/m_movie/provider/m_movie_provider.dart';
import 'package:nvc_cinemas/feature/movie/model/movie_model.dart';
import 'package:nvc_cinemas/feature/movie/widget/custom_search_delegate.dart';
import 'package:nvc_cinemas/gen/assets.gen.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:nvc_cinemas/l10n/l10n.dart';
import 'package:nvc_cinemas/shared/util/init_util.dart';

class SearchPage extends ConsumerWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movies = ref.watch(moviesProvider);
    final moviesActive = <MovieModel>[];
    for (final item in movies) {
      if (item.active!) {
        moviesActive.add(item);
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorName.primary,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(
                    context: context,
                    delegate: CustomSearchDelegate(moviesActive));
              },
              icon: const Icon(
                Icons.search,
                color: Colors.black,
              ))
        ],
        title: Text(
          'Tìm kiếm phim',
          style: TextStyle(
            color: ColorName.btnText,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: ListView.builder(
            itemCount: moviesActive.length,
            itemBuilder: (context, index) {
              final category = ref
                  .read(categoriesProvider.notifier)
                  .getById(moviesActive[index].category!);

              return GestureDetector(
                onTap: () {
                  InitUtil.initBookingByMovie(ref: ref);
                  Navigator.pushNamed(context, '/booking-by-movie',
                      arguments: moviesActive[index]);
                },
                child: ListTile(
                  title: Text(
                    moviesActive[index].movieNameVi!,
                    style: TextStyle(
                      color: ColorName.btnText,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    '${moviesActive[index].duration} ${context.l10n.minutes.toLowerCase()} | ${category.categoryName}',
                    style: TextStyle(
                      color: ColorName.btnText,
                      fontSize: 15,
                    ),
                  ),
                  leading: moviesActive[index].image != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: moviesActive[index].image!.contains('/m/')
                              ? Image.asset(
                                  moviesActive[index].image!,
                                  fit: BoxFit.cover,
                                )
                              : Image.file(
                                  File(moviesActive[index].image!),
                                  fit: BoxFit.cover,
                                ),
                        )
                      : Assets.images.logoPng
                          .image(width: 100, fit: BoxFit.contain),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 22,
                    color: ColorName.primary,
                  ),
                ),
              );
            }),
      ),
    );
  }
}
