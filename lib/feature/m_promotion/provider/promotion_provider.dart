import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/feature/m_promotion/model/promotion_model.dart';
import 'package:nvc_cinemas/shared/link/promotions.dart';
import 'package:nvc_cinemas/shared/util/function_ulti.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:uuid/uuid.dart';

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

  void editPromotion(PromotionModel promotion) {
    state = [
      for (final item in state)
        if (item.id == promotion.id)
          item.copyWith(
            name: promotion.name,
            content: promotion.content,
            image: promotion.image,
            code: promotion.code,
            startTime: promotion.startTime,
            endTime: promotion.endTime,
            active: promotion.active,
            createAt: promotion.createAt,
            updateAt: promotion.updateAt,
          )
        else
          item,
    ];
  }

  void switchActive(String id, bool value) {
    state = [
      for (final item in state)
        if (item.id == id)
          item.copyWith(
            active: value,
          )
        else
          item,
    ];
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
    'active': FormControl<String>(),
  });

  final buttonController = RoundedLoadingButtonController();

  Future<void> addPromotion(WidgetRef ref, BuildContext context) async {
    buttonController.start();
    await Future.delayed(const Duration(milliseconds: 700));
    final name = addPromotionForm.control('name').value;
    final content = addPromotionForm.control('content').value;
    final image = addPromotionForm.control('image').value;
    final code = addPromotionForm.control('code').value;
    final startTime = addPromotionForm.control('startTime').value;
    final endTime = addPromotionForm.control('endTime').value;
    final promotion = PromotionModel(
      id: Uuid().v4(),
      name: name,
      content: content,
      image: image,
      code: code == 'Chọn mã' ? '' : code,
      active: true,
      startTime: int.parse(startTime),
      endTime: int.parse(endTime),
      createAt: DateTime.now().millisecondsSinceEpoch,
      updateAt: DateTime.now().millisecondsSinceEpoch,
    );
    ref.read(promotionsProvider.notifier).add(promotion);
    FunctionUtil.alertPopUpCreated(onPressedConfirm: () {
      Navigator.pop(context);
    });
    buttonController.reset();
  }

  Future<void> editPromotion(
    WidgetRef ref,
    BuildContext context,
    PromotionModel promotionModel,
  ) async {
    buttonController.start();
    await Future.delayed(const Duration(milliseconds: 700));
    final name = addPromotionForm.control('name').value;
    final content = addPromotionForm.control('content').value;
    final image = addPromotionForm.control('image').value;
    final code = addPromotionForm.control('code').value;
    final startTime = addPromotionForm.control('startTime').value;
    final endTime = addPromotionForm.control('endTime').value;
    final active = addPromotionForm.control('active').value;
    final promotion = PromotionModel(
      id: promotionModel.id,
      name: name,
      content: content,
      image: image,
      code: code == 'Chọn mã' ? '' : code,
      startTime: int.parse(startTime),
      endTime: int.parse(endTime),
      active: active == 'true' ? true : false,
      createAt: promotionModel.createAt,
      updateAt: DateTime.now().millisecondsSinceEpoch,
    );
    ref.read(promotionsProvider.notifier).editPromotion(promotion);
    FunctionUtil.alertPopUpUpdated(onPressedConfirm: () {
      Navigator.pop(context);
    });
    buttonController.reset();
  }

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

final startTimeAddPromotionProvider =
    StateNotifierProvider<StartTimeAddPromotionNotifier, String>(
  (ref) => StartTimeAddPromotionNotifier(),
);

class StartTimeAddPromotionNotifier extends StateNotifier<String> {
  StartTimeAddPromotionNotifier() : super('0');

  void update(String value) {
    state = value;
  }
}

final endTimeAddPromotionProvider =
    StateNotifierProvider<EndTimeAddPromotionNotifier, String>(
  (ref) => EndTimeAddPromotionNotifier(),
);

class EndTimeAddPromotionNotifier extends StateNotifier<String> {
  EndTimeAddPromotionNotifier() : super('0');

  void update(String value) {
    state = value;
  }
}

final imageAddPromotionProvider =
    StateNotifierProvider<ImageAddPromotionNotifier, String>(
  (ref) => ImageAddPromotionNotifier(),
);

class ImageAddPromotionNotifier extends StateNotifier<String> {
  ImageAddPromotionNotifier() : super('');

  void update(String value) {
    state = value;
  }
}
