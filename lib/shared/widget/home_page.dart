import 'package:nvc_cinemas/feature/home/widget/home.dart';
import 'package:nvc_cinemas/feature/m_category/widget/m_category_page.dart';
import 'package:nvc_cinemas/feature/m_movie/m_movie_page.dart';
import 'package:nvc_cinemas/feature/movie/widget/movie_page.dart';
import 'package:nvc_cinemas/feature/promotion/widget/promotion_page.dart';
import 'package:nvc_cinemas/feature/showtimes/widget/showtimes_page.dart';
import 'package:nvc_cinemas/feature/ticket/widget/ticket_page.dart';
import 'package:nvc_cinemas/gen/assets.gen.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:nvc_cinemas/l10n/l10n.dart';
import 'package:nvc_cinemas/shared/enum/navigation_item.dart';
import 'package:nvc_cinemas/shared/provider/navigation_provider.dart';
import 'package:nvc_cinemas/shared/provider/user_provider.dart';
import 'package:nvc_cinemas/shared/widget/bottom_navigation_widget.dart';
import 'package:nvc_cinemas/shared/widget/drawer_widget.dart';
import 'package:nvc_cinemas/shared/widget/see_more_screen.dart';
import 'package:nvc_cinemas/shared/widget/snack_bar_support.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with WidgetsBindingObserver {
  var _isInForeground = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    Future.delayed(const Duration(seconds: 3), () {
      // final profile = ref.watch(profileProvider);
      // if (profile.name != null) {
      //   // InitUtil.initProfile(ref, this);
      // }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    _isInForeground = state == AppLifecycleState.resumed;

    switch (state) {
      case AppLifecycleState.resumed:
        print('app in resumed - homepage');
        break;
      case AppLifecycleState.inactive:
        print('app in inactive - homepage');
        break;
      case AppLifecycleState.paused:
        print('app in paused - homepage');
        break;
      case AppLifecycleState.detached:
        print('app in detached - homepage');
        break;
    }
    print(_isInForeground);
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    var timeBackPress = DateTime.now();
    // final profile = ref.watch(profileProvider);
    final user = ref.watch(userProvider);
    var role = 'customer';
    if (user.role != null) {
      role = user.role!.roleName!;
    }
    final isCustomer = role != 'admin' && role != 'manager';

    return WillPopScope(
      onWillPop: () async {
        final difference = DateTime.now().difference(timeBackPress);
        final isExitWarning = difference >= const Duration(seconds: 2);
        timeBackPress = DateTime.now();

        if (isExitWarning) {
          final messageExitWarning = context.l10n.pressBackAgainToExit;
          SnackBarSupport.createAndDisplay(
            context: context,
            content: messageExitWarning,
            timeSecond: 2,
            hideAction: false,
          );

          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: ColorName.pageBackground,
          // backgroundColor: Colors.red,
          iconTheme: IconThemeData(color: Colors.black87),
          toolbarHeight: 60,
          elevation: 3,
          flexibleSpace: SafeArea(
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: isCustomer
                        ? () => ref
                            .read(navigationProvider.notifier)
                            .setNavigationItem(NavigationItem.home)
                        : () => ref
                            .read(navigationProvider.notifier)
                            .setNavigationItem(NavigationItem.mCategory),
                    child: Container(
                        margin: const EdgeInsets.only(left: 40),
                        child: Assets.images.logoPng
                            .image(width: 90, fit: BoxFit.contain)),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(
                      context,
                      '/account-information',
                    ),
                    child: CircleAvatar(
                      backgroundColor: const Color(0xFFB7CFFC),
                      radius: 20,
                      child: Text(
                        user.fullName != null
                            ? ref.read(userProvider.notifier).getSortName()
                            : 'C',
                        style: const TextStyle(
                            color: Color(0xFF4B5574),
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [Container()],
        ),
        drawer: DrawerWidget(),
        body: buildPage(context, ref),
        bottomNavigationBar: const BottomNavigationWidget(),
      ),
    );
  }

  Widget getPage(NavigationItem item) {
    Widget widget;
    final map = {
      NavigationItem.home: const Home(),
      NavigationItem.seeMore: const SeeMoreScreen(),
      NavigationItem.movie: const MoviePage(),
      NavigationItem.showtimes: const ShowtimesPage(),
      NavigationItem.mCategory: const MCategoryPage(),
      NavigationItem.mMovie: const MMoviePage(),
      // NavigationItem.ticket: const TicketPage(),
      // NavigationItem.promotions: const PromotionPage(),
    };
    widget = map[item] ?? Home();

    return widget;
  }

  Widget buildPage(BuildContext context, WidgetRef ref) {
    final currentSelected = ref.watch(navigationProvider)! as NavigationItem;

    return getPage(currentSelected);
  }
}
