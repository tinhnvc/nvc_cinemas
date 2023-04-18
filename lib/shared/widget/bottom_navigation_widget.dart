import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:nvc_cinemas/l10n/l10n.dart';
import 'package:nvc_cinemas/shared/enum/navigation_item.dart';
import 'package:nvc_cinemas/shared/provider/navigation_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/shared/provider/user_provider.dart';
import 'package:nvc_cinemas/shared/util/init_util.dart';

final indexProvider = StateNotifierProvider((ref) => IndexNavigationBar());

class IndexNavigationBar extends StateNotifier<int> {
  IndexNavigationBar() : super(0);

  set value(int index) => state = index;
}

class BottomNavigationWidget extends ConsumerWidget {
  const BottomNavigationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var role = 'customer';
    final user = ref.watch(userProvider);
    if (user.role != null) {
      role = user.role!.roleName!;
    }
    final isCustomer = role != 'admin' && role != 'manager';

    final navigationItem = ref.watch(navigationProvider);
    var currentIndex = 0;
    switch (navigationItem) {
      case NavigationItem.home:
        currentIndex = 0;
        break;
      case NavigationItem.movie:
        currentIndex = 1;
        break;
      // case NavigationItem.sales:
      case NavigationItem.showtimes:
        currentIndex = 2;
        break;
      case NavigationItem.seeMore:
        currentIndex = 3;
        break;
      case NavigationItem.mCategory:
        currentIndex = 0;
        break;
      case NavigationItem.mMovie:
        currentIndex = 1;
        break;
      case NavigationItem.mRoom:
        currentIndex = 2;
        break;
      default:
        currentIndex = 3;
    }

    NavigationItem convertIndex(int index) {
      if (index == 2) {
        InitUtil.initBookingByMovie(ref: ref);
      }
      switch (index) {
        case 0:
          return NavigationItem.home;
        case 1:
          return NavigationItem.movie;
        case 2:
          return NavigationItem.showtimes;
        case 3:
          return NavigationItem.seeMore;
        default:
          return NavigationItem.home;
      }
    }

    NavigationItem convertIndexAdmin(int index) {
      switch (index) {
        case 0:
          return NavigationItem.mCategory;
        case 1:
          return NavigationItem.mMovie;
        case 2:
          return NavigationItem.mRoom;
        case 3:
          return NavigationItem.seeMore;
        default:
          return NavigationItem.mCategory;
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
          indicatorColor: ColorName.primary.withOpacity(0.15),
          labelTextStyle: MaterialStateProperty.all(
            const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: ColorName.primary,
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
            isCustomer
                ? ref.read(navigationProvider.notifier).setNavigationItem(
                      convertIndex(index),
                    )
                : ref.read(navigationProvider.notifier).setNavigationItem(
                      convertIndexAdmin(index),
                    );
          },
          destinations: [
            if (isCustomer)
              NavigationDestination(
                selectedIcon: Icon(
                  Icons.home,
                  color: ColorName.primary.withOpacity(0.8),
                ),
                icon: Icon(
                  Icons.home_outlined,
                  color: ColorName.primary.withOpacity(0.8),
                ),
                label: context.l10n.home,
              ),
            if (isCustomer)
              NavigationDestination(
                selectedIcon: Icon(
                  Icons.video_collection,
                  color: ColorName.primary.withOpacity(0.8),
                ),
                icon: Icon(
                  Icons.video_collection_outlined,
                  color: ColorName.primary.withOpacity(0.8),
                ),
                label: context.l10n.movie,
              ),
            if (isCustomer)
              NavigationDestination(
                selectedIcon: Icon(
                  Icons.calendar_month,
                  color: ColorName.primary.withOpacity(0.8),
                ),
                icon: Icon(
                  Icons.calendar_today,
                  color: ColorName.primary.withOpacity(0.8),
                ),
                label: context.l10n.showtimes,
              ),
// with admin or manager:
            if (!isCustomer)
              NavigationDestination(
                selectedIcon: Icon(
                  Icons.category,
                  color: ColorName.primary.withOpacity(0.8),
                ),
                icon: Icon(
                  Icons.category_outlined,
                  color: ColorName.primary.withOpacity(0.8),
                ),
                label: context.l10n.categories,
              ),
            if (!isCustomer)
              NavigationDestination(
                selectedIcon: Icon(
                  Icons.videocam_rounded,
                  color: ColorName.primary.withOpacity(0.8),
                ),
                icon: Icon(
                  Icons.videocam_outlined,
                  color: ColorName.primary.withOpacity(0.8),
                ),
                label: context.l10n.movie,
              ),
            if (!isCustomer)
              NavigationDestination(
                selectedIcon: Icon(
                  Icons.dataset,
                  color: ColorName.primary.withOpacity(0.8),
                ),
                icon: Icon(
                  Icons.dataset_outlined,
                  color: ColorName.primary.withOpacity(0.8),
                ),
                label: context.l10n.rooms,
              ),
            NavigationDestination(
              selectedIcon: Icon(
                Icons.more,
                color: ColorName.primary.withOpacity(0.8),
              ),
              icon: Icon(
                Icons.more_outlined,
                color: ColorName.primary.withOpacity(0.8),
              ),
              label: context.l10n.seeMore,
            ),
          ],
        ),
      ),
    );
  }
}
