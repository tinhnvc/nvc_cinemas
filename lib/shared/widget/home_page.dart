import 'package:nvc_cinemas/l10n/l10n.dart';
import 'package:nvc_cinemas/shared/enum/navigation_item.dart';
import 'package:nvc_cinemas/shared/provider/navigation_provider.dart';
import 'package:nvc_cinemas/shared/widget/bottom_navigation_widget.dart';
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
          backgroundColor: Colors.white,
          toolbarHeight: 80,
          elevation: 0,
          actions: [Container()],
        ),
        body: buildPage(context, ref),
        bottomNavigationBar: const BottomNavigationWidget(),
      ),
    );
  }

  Widget getPage(NavigationItem item) {
    Widget widget;
    final map = {
      NavigationItem.home: const HomePage(),
      // NavigationItem.notification: const NotificationPage(),
      // NavigationItem.ticket: const Ticket(),
      // NavigationItem.history: const History(),
      // NavigationItem.seeMore: const SeeMoreScreen(),SeeMoreScreen
    };
    widget = map[item] ?? HomePage();

    return widget;
  }

  Widget buildPage(BuildContext context, WidgetRef ref) {
    final currentSelected = ref.watch(navigationProvider)! as NavigationItem;

    return getPage(currentSelected);
  }
}
