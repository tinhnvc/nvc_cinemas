import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/feature/home/widget/propose_movie_widget.dart';
import 'package:nvc_cinemas/feature/m_category/provider/category_provider.dart';
import 'package:nvc_cinemas/feature/m_movie/provider/m_movie_provider.dart';
import 'package:nvc_cinemas/feature/m_seat/provider/seat_type_provider.dart';
import 'package:nvc_cinemas/feature/movie/provider/day_of_week_provider.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:nvc_cinemas/l10n/l10n.dart';
import 'package:nvc_cinemas/shared/link/assets.dart';
import 'package:nvc_cinemas/shared/provider/user_provider.dart';
import 'package:nvc_cinemas/shared/provider/util_provider.dart';
import 'package:nvc_cinemas/shared/service/file_service.dart';
import 'package:nvc_cinemas/shared/widget/search_widget.dart';

class Home extends ConsumerStatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    final inset = MediaQuery.of(context).viewInsets;
    final height = size.height - (padding.top + padding.bottom + inset.bottom);
    final width = size.width - (padding.left + padding.right + inset.right);
    final ratio = height / size.width;
    final user = ref.watch(userProvider);
    final movies = ref
        .watch(moviesProvider)
        ..sort((a, b) => a.startTime!.compareTo(b.startTime!));
    final language = ref.watch(languageProvider);
    ref.watch(seatTypesProvider);
    ref.watch(categoriesProvider);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: ColorName.pageBackground,
      // endDrawer: const EndDrawerWidget(),
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
                    GestureDetector(
                      onTap: () async {
                        final imagePath = await FileService.pickImage();
                        print(imagePath);
                      },
                      child: Text(
                        '${context.l10n.hi}, ${user.fullName}',
                        style: TextStyle(
                          color: ColorName.btnText,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      language == 'vi'
                          ? '${movies[0].movieNameVi} '
                              '${context.l10n.comingSoon.toLowerCase()},'
                              ' ${context.l10n.bookTicketNow.toLowerCase()}!'
                          : '${movies[0].movieNameEn} '
                              '${context.l10n.comingSoon.toLowerCase()},'
                              ' ${context.l10n.bookTicketNow.toLowerCase()}!',
                      style: TextStyle(
                        color: ColorName.btnText,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SearchWidget(searchHint: 'Sự trở lại của Askhan'),
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
                    Text(
                      context.l10n.propose,
                      style: TextStyle(
                        color: ColorName.btnText,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
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
                        maxCrossAxisExtent: 330.0,
                        mainAxisExtent: 270,
                        crossAxisSpacing: 12.0,
                        mainAxisSpacing: 12.0,
                      ),
                      itemCount: movies.length,
                      itemBuilder: (context, index) => ProposeMovieWidget(
                        movie: movies[index],
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

final indexPageViewHomeScreen =
    StateNotifierProvider((ref) => IndexPageViewHomeScreen());

class IndexPageViewHomeScreen extends StateNotifier<int> {
  IndexPageViewHomeScreen() : super(0);

  set value(int index) => state = index;
}
