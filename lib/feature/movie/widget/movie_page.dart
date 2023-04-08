import 'dart:io';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/feature/home/widget/propose_movie_widget.dart';
import 'package:nvc_cinemas/feature/movie/widget/movie_item.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:nvc_cinemas/l10n/l10n.dart';
import 'package:nvc_cinemas/shared/link/assets.dart';
import 'package:nvc_cinemas/shared/provider/user_provider.dart';

class MoviePage extends ConsumerWidget {
  const MoviePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    final inset = MediaQuery.of(context).viewInsets;
    final height = size.height - (padding.top + padding.bottom + inset.bottom);
    final width = size.width - (padding.left + padding.right + inset.right);
    final ratio = height / size.width;
    final user = ref.watch(userProvider);

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
                margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          context.l10n.nowShowing.toUpperCase(),
                          style: TextStyle(
                            color: ColorName.btnText,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          context.l10n.comingSoon.toUpperCase(),
                          style: TextStyle(
                            color: ColorName.btnText,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 150,
                      child: Swiper(
                        itemCount: 3,
                        autoplay: true,
                        control: const SwiperControl(color: Colors.white54),
                        pagination: const SwiperPagination(
                          alignment: Alignment.bottomCenter,
                          builder: DotSwiperPaginationBuilder(
                            activeColor: ColorName.primary,
                            color: Colors.white,
                            size: 8.0,
                            activeSize: 8.0,
                          ),
                        ),
                        itemBuilder: (context, index) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            image: DecorationImage(
                              image: AssetImage(carouselsImage[index]),
                              fit: BoxFit.cover,
                            ),
                          ),
                          margin: const EdgeInsets.all(0),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          // const SliverGridDelegateWithFixedCrossAxisCount(
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 150.0,
                        mainAxisExtent: 250,
                        crossAxisSpacing: 12.0,
                        mainAxisSpacing: 12.0,
                      ),
                      itemCount: 10,
                      itemBuilder: (context, index) => InkWell(
                        onTap: () =>
                            Navigator.pushNamed(context, '/booking-by-movie'),
                        child: MovieItem(),
                      ),
                    )
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

final indexPageViewMovieScreen =
    StateNotifierProvider((ref) => IndexPageViewMovieScreen());

class IndexPageViewMovieScreen extends StateNotifier<int> {
  IndexPageViewMovieScreen() : super(0);

  set value(int index) => state = index;
}
