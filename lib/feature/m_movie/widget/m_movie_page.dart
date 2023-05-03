import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/feature/m_category/provider/category_provider.dart';
import 'package:nvc_cinemas/feature/m_movie/provider/m_movie_provider.dart';
import 'package:nvc_cinemas/feature/m_movie/widget/m_movie_item.dart';
import 'package:nvc_cinemas/feature/movie/model/category_model.dart';
import 'package:nvc_cinemas/feature/movie/model/movie_model.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:nvc_cinemas/l10n/l10n.dart';
import 'package:nvc_cinemas/shared/provider/user_provider.dart';
import 'package:nvc_cinemas/shared/provider/util_provider.dart';
import 'package:nvc_cinemas/shared/util/init_util.dart';

class MMoviePage extends ConsumerWidget {
  const MMoviePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    final inset = MediaQuery.of(context).viewInsets;
    final height = size.height - (padding.top + padding.bottom + inset.bottom);
    final width = size.width - (padding.left + padding.right + inset.right);
    final ratio = height / size.width;
    final user = ref.watch(userProvider);
    final isVietnamese = ref.watch(languageProvider) == 'vi';
    final categories = [
      CategoryModel(
          id: 'all',
          categoryName: context.l10n.all,
          categoryNameEn: context.l10n.all),
      ...ref.watch(categoriesProvider)
    ];
    final allMovies = ref.watch(moviesProvider);
    var movies = <MovieModel>[];

    final categorySelect = ref.watch(categorySelectFilterProvider);
    final categoriesFilter = ref.watch(categoriesFilterProvider);
    if (categorySelect == 'Tất cả') {
      movies = ref.watch(moviesProvider)
        ..sort(
          (a, b) => a.startTime!.compareTo(b.startTime!),
        );
    }

    if (categorySelect != 'Tất cả') {
      for (final item in allMovies) {
        final category =
            ref.read(categoriesProvider.notifier).getByName(categorySelect);
        if (item.category == category.id) {
          movies.add(item);
        }
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: ColorName.pageBackground,
      // endDrawer: const EndDrawerWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          InitUtil.initAddMovie(ref: ref);
          Navigator.pushNamed(context, '/add-movie');
        },
        child: Icon(
          Icons.add,
          size: 25,
          color: Colors.white,
        ),
      ),
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          children: [
            SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          context.l10n.movie,
                          style: TextStyle(
                            color: ColorName.btnText,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: width,
                      height: 25,
                      child: ListView(
                        physics: AlwaysScrollableScrollPhysics(
                            parent: BouncingScrollPhysics()),
                        scrollDirection: Axis.horizontal,
                        children: [
                          SizedBox(
                            width: width,
                            height: 70,
                            child: ListView(
                              physics: AlwaysScrollableScrollPhysics(
                                  parent: BouncingScrollPhysics()),
                              scrollDirection: Axis.horizontal,
                              children: categoriesFilter
                                  .map(
                                    (e) => GestureDetector(
                                      onTap: () {
                                        ref
                                            .read(categorySelectFilterProvider
                                                .notifier)
                                            .update(e);
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                          left: 15,
                                          right: 5,
                                        ),
                                        child: Text(
                                          e,
                                          style: TextStyle(
                                            color: ColorName.btnText,
                                            fontSize: 15,
                                            fontWeight: e == categorySelect
                                                ? FontWeight.bold
                                                : null,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Có ${movies.length} kết quả',
                      style: TextStyle(
                        fontSize: 14,
                        color: ColorName.textNormal,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: movies.isNotEmpty
                          ? movies
                              .map((e) => MMovieItem(
                                    movie: e,
                                  ))
                              .toList()
                          : [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 50,
                                  ),
                                  Text(
                                    'Không tìm thấy kết quả nào',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
