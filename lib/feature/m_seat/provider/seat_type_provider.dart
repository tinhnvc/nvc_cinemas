import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/feature/m_seat/model/seat_type_model.dart';
import 'package:nvc_cinemas/shared/link/seat_types.dart';
import 'package:nvc_cinemas/shared/util/format_support.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

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

    return '${FormatSupport.toMoney(int.parse(result))}đ';
  }
}

final seatFormProvider = Provider<SeatFormProvider>(
  (ref) => SeatFormProvider(),
);

class SeatFormProvider {
  SeatFormProvider();

  final addSeatForm = FormGroup({
    'typeName': FormControl<String>(),
    'price': FormControl<String>(),
    'otherPrice': FormControl<String>(),
  });

  final buttonController = RoundedLoadingButtonController();

  Future<void> addSeat(WidgetRef ref, BuildContext context) async {}

  Future<void> editSeat(WidgetRef ref, BuildContext context) async {}

  Future<void> changeStatus(WidgetRef ref, BuildContext context) async {}
}
