import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

final roomFormProvider = Provider<MovieFormProvider>(
      (ref) => MovieFormProvider(),
);

class MovieFormProvider {
  MovieFormProvider();

  final addRoomForm = FormGroup({
    'roomName': FormControl<String>(),
    'seatAmount': FormControl<String>(),
    'sizeW': FormControl<String>(),
    'sizeH': FormControl<String>(),
    'seats': FormControl<String>(),
  });

  final buttonController = RoundedLoadingButtonController();

  Future<void> addRoom(WidgetRef ref, BuildContext context) async {}

  Future<void> editRoom(WidgetRef ref, BuildContext context) async {}

  Future<void> changeStatus(WidgetRef ref, BuildContext context) async {}
}

final roomAddShowtimeProvider =
StateNotifierProvider<RoomAddShowtimeNotifier, String>(
      (ref) => RoomAddShowtimeNotifier(),
);

class RoomAddShowtimeNotifier extends StateNotifier<String> {
  RoomAddShowtimeNotifier() : super('');

  void update(String value) {
    state = value;
  }
}
