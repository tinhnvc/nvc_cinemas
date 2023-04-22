import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/feature/m_seat/model/seat_type_model.dart';
import 'package:nvc_cinemas/shared/link/seat_types.dart';
import 'package:nvc_cinemas/shared/util/format_support.dart';
import 'package:nvc_cinemas/shared/util/function_ulti.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:uuid/uuid.dart';

final seatTypesProvider =
    StateNotifierProvider<SeatTypesNotifier, List<SeatTypeModel>>(
  (ref) => SeatTypesNotifier(),
);

class SeatTypesNotifier extends StateNotifier<List<SeatTypeModel>> {
  SeatTypesNotifier() : super([]) {
    fetchSeatTypes();
  }

  Future<void> fetchSeatTypes() async {
    final seatTypesFetch = seatTypesFromJson(seatTypes);
    state = seatTypesFetch;
  }

  void add(SeatTypeModel seatType) {
    state = [...state, seatType];
  }

  void editSeatType(SeatTypeModel seatType) {
    state = [
      for (final item in state)
        if (item.id == seatType.id)
          item.copyWith(
            typeName: seatType.typeName,
            price: seatType.price,
            otherPrice: seatType.otherPrice,
            active: seatType.active,
            isDefault: seatType.isDefault,
            createAt: seatType.createAt,
            updateAt: seatType.updateAt,
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

  String getPriceByIndex(int index) {
    var result = '45000';
    final today = DateTime.now().weekday;
    if (state.isNotEmpty) {
      if (today == 6 || today == 7) {
        result = state[index].otherPrice.toString();
      } else {
        result = state[index].price.toString();
      }
    }

    return '${FormatSupport.toMoney(int.parse(result))}đ';
  }

  SeatTypeModel getById(String id) {
    var seatType = const SeatTypeModel();
    if (state.isNotEmpty) {
      for (final item in state) {
        if (item.id == id) {
          seatType = item;
        }
      }
    }
    return seatType;
  }

  String getPriceById(String id) {
    var result = '45000';
    final today = DateTime.now().weekday;
    if (state.isNotEmpty) {
      final seatType = getById(id);
      if (today == 6 || today == 7) {
        result = seatType.otherPrice.toString();
      } else {
        result = seatType.price.toString();
      }
    }

    return result;
  }
}

final seatTypeFormProvider = Provider<SeatTypeFormProvider>(
  (ref) => SeatTypeFormProvider(),
);

class SeatTypeFormProvider {
  SeatTypeFormProvider();

  final addSeatTypeForm = FormGroup({
    'typeName': FormControl<String>(),
    'price': FormControl<String>(),
    'otherPrice': FormControl<String>(),
    'active': FormControl<String>(),
  });

  final buttonController = RoundedLoadingButtonController();

  Future<void> addSeat(WidgetRef ref, BuildContext context) async {
    buttonController.start();
    await Future.delayed(const Duration(milliseconds: 700));
    final typeName = addSeatTypeForm.control('typeName').value;
    final price = addSeatTypeForm.control('price').value;
    final otherPrice = addSeatTypeForm.control('otherPrice').value;
    final seatType = SeatTypeModel(
      id: Uuid().v4(),
      typeName: typeName,
      price: int.parse(price),
      otherPrice: int.parse(otherPrice),
      active: true,
      isDefault: false,
      createAt: DateTime.now().millisecondsSinceEpoch,
      updateAt: DateTime.now().millisecondsSinceEpoch,
    );
    ref.read(seatTypesProvider.notifier).add(seatType);
    FunctionUtil.alertPopUpCreated(onPressedConfirm: () {
      Navigator.pop(context);
    });
    buttonController.reset();
  }

  Future<void> editSeat(
    WidgetRef ref,
    BuildContext context,
    SeatTypeModel seatTypeModel,
  ) async {
    buttonController.start();
    await Future.delayed(const Duration(milliseconds: 700));
    final typeName = addSeatTypeForm.control('typeName').value;
    final price = addSeatTypeForm.control('price').value;
    final otherPrice = addSeatTypeForm.control('otherPrice').value;
    final active = addSeatTypeForm.control('active').value;
    final seatType = SeatTypeModel(
      id: seatTypeModel.id,
      typeName: typeName,
      price: int.parse(price),
      otherPrice: int.parse(otherPrice),
      active: active == 'true' ? true : false,
      createAt: seatTypeModel.createAt,
      updateAt: DateTime.now().millisecondsSinceEpoch,
    );
    ref.read(seatTypesProvider.notifier).editSeatType(seatType);
    FunctionUtil.alertPopUpUpdated(onPressedConfirm: () {
      Navigator.pop(context);
    });
    buttonController.reset();
  }

  Future<void> changeStatus(WidgetRef ref, BuildContext context) async {}
}
