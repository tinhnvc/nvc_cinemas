import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/shared/enum/navigation_item.dart';

final navigationProvider = StateNotifierProvider((ref) => NavigationProvider());

class NavigationProvider extends StateNotifier<NavigationItem> {
  NavigationProvider() : super(NavigationItem.home);

  void setNavigationItem(NavigationItem item) {
    state = item;
  }
}
