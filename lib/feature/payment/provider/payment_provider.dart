import 'package:flutter_riverpod/flutter_riverpod.dart';

final couponCodeProvider = StateNotifierProvider<CouponCodeNotifier, String>(
  (ref) => CouponCodeNotifier(),
);

class CouponCodeNotifier extends StateNotifier<String> {
  CouponCodeNotifier() : super('');

  void update(String value) {
    state = value;
  }
}
