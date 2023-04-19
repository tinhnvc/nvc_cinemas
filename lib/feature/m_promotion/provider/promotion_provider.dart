import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/feature/m_promotion/model/promotion_model.dart';
import 'package:nvc_cinemas/shared/link/promotions.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

final promotionsProvider =
    StateNotifierProvider<PromotionNotifier, List<PromotionModel>>(
  (ref) => PromotionNotifier(),
);

class PromotionNotifier extends StateNotifier<List<PromotionModel>> {
  PromotionNotifier() : super([]) {
    fetchPromotions();
  }

  Future<void> fetchPromotions() async {
    final promotionsFetch = promotionsFromJson(promotions);
    state = promotionsFetch;
  }

  PromotionModel getById(String id) {
    var promotion = const PromotionModel();
    if (state.isNotEmpty) {
      for (final item in state) {
        if (item.id == id) {
          promotion = item;
        }
      }
    }

    return promotion;
  }

  void add(PromotionModel room) {
    state = [...state, room];
  }
}

final promotionFormProvider = Provider<PromotionFormProvider>(
  (ref) => PromotionFormProvider(),
);

class PromotionFormProvider {
  PromotionFormProvider();

  final addPromotionForm = FormGroup({
    'name': FormControl<String>(),
    'content': FormControl<String>(),
    'image': FormControl<String>(),
    'code': FormControl<String>(),
    'startTime': FormControl<String>(),
    'endTime': FormControl<String>(),
  });

  final buttonController = RoundedLoadingButtonController();

  Future<void> addMovie(WidgetRef ref, BuildContext context) async {}

  Future<void> editMovie(WidgetRef ref, BuildContext context) async {}

  Future<void> changeStatus(WidgetRef ref, BuildContext context) async {}
}

final codeAddPromotionProvider =
    StateNotifierProvider<CodeAddPromotionNotifier, String>(
  (ref) => CodeAddPromotionNotifier(),
);

class CodeAddPromotionNotifier extends StateNotifier<String> {
  CodeAddPromotionNotifier() : super('');

  void update(String value) {
    state = value;
  }
}
