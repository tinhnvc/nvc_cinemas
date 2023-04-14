import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

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
