import 'package:flutter_riverpod/flutter_riverpod.dart';

final isSelectRevenueMovieProvider =
StateNotifierProvider((ref) => RevenueFilterNotifier());

class RevenueFilterNotifier extends StateNotifier<bool> {
  RevenueFilterNotifier() : super(true);

  set changed(bool value) => state = value;
}