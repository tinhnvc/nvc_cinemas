import 'package:nvc_cinemas/l10n/l10n.dart';
import 'package:nvc_cinemas/shared/enum/navigation_item.dart';
import 'package:nvc_cinemas/shared/provider/navigation_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final indexProvider = StateNotifierProvider((ref) => IndexNavigationBar());

class IndexNavigationBar extends StateNotifier<int> {
  IndexNavigationBar() : super(0);

  set value(int index) => state = index;
}

class BottomNavigationWidget extends ConsumerWidget {
  const BottomNavigationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final profile = ref.watch(profileProvider);
    final navigationItem = ref.watch(navigationProvider);
    var currentIndex = 0;
    switch (navigationItem) {
      case NavigationItem.home:
        currentIndex = 0;
        break;
      case NavigationItem.notification:
        currentIndex = 1;
        break;
      // case NavigationItem.sales:
      case NavigationItem.ticket:
        currentIndex = 2;
        break;
      case NavigationItem.seeMore:
        currentIndex = 3;
        break;
      default:
        currentIndex = 3;
    }

    NavigationItem convertIndex(int index) {
      switch (index) {
        case 0:
          return NavigationItem.home;
        case 1:
          return NavigationItem.notification;
        case 2:
          return NavigationItem.ticket;
        case 3:
          return NavigationItem.seeMore;
        default:
          return NavigationItem.home;
      }
    }

    return Container(
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: const Color(0xFF6968BE).withOpacity(0.15),
          labelTextStyle: MaterialStateProperty.all(
            const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Color(0xFF6968BE),
            ),
          ),
        ),
        child: NavigationBar(
          selectedIndex: currentIndex,
          backgroundColor: Colors.white,
          // labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          animationDuration: const Duration(seconds: 1),
          height: 65,
          onDestinationSelected: (index) {
            ref.read(navigationProvider.notifier).setNavigationItem(
                  convertIndex(index),
                );
          },
          destinations: [
            const NavigationDestination(
              selectedIcon: Icon(
                Icons.home,
                color: Color(0XFFBFEBEE),
              ),
              icon: Icon(
                Icons.home_outlined,
                color: Color(0XFFBFEBEE),
              ),
              label: 'Trang chủ',
            ),
            NavigationDestination(
              selectedIcon: const Icon(
                Icons.notifications,
                color: Color(0XFFBFEBEE),
              ),
              icon: const Icon(
                Icons.notifications_none,
                color: Color(0XFFBFEBEE),
              ),
              label: 'Thông báo',
            ),
            NavigationDestination(
              selectedIcon: const Icon(
                Icons.sticky_note_2_rounded,
                color: Color(0XFFBFEBEE),
              ),
              icon: const Icon(
                Icons.sticky_note_2_outlined,
                color: Color(0XFFBFEBEE),
              ),
              label: 'Ticket',
            ),
            NavigationDestination(
              selectedIcon: const Icon(
                Icons.more,
                color: Color(0XFFBFEBEE),
              ),
              icon: const Icon(
                Icons.more_outlined,
                color: Color(0XFFBFEBEE),
              ),
              label: context.l10n.seeMore,
            ),
          ],
        ),
      ),
    );
  }
}
