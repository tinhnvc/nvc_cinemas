import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/feature/m_room/model/room_model.dart';
import 'package:nvc_cinemas/shared/link/rooms.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

final roomsProvider = StateNotifierProvider<RoomsNotifier, List<RoomModel>>(
  (ref) => RoomsNotifier(),
);

class RoomsNotifier extends StateNotifier<List<RoomModel>> {
  RoomsNotifier() : super([]) {
    fetchRooms();
  }

  Future<void> fetchRooms() async {
    final roomsFetch = roomsFromJson(rooms);
    state = roomsFetch;
  }

  RoomModel getById(String id) {
    var room = const RoomModel();
    if (state.isNotEmpty) {
      for (final item in state) {
        if (item.id == id) {
          room = item;
        }
      }
    }

    return room;
  }

  RoomModel getByName(String roomName) {
    var room = const RoomModel();
    if (state.isNotEmpty) {
      for (final item in state) {
        if (item.name == roomName) {
          room = item;
        }
      }
    }

    return room;
  }

  bool isActiveRoom() {
    for (final item in state) {
      if (item.active!) {
        return true;
      }
    }
    return false;
  }

  void add(RoomModel room) {
    state = [...state, room];
  }
}

final roomFormProvider = Provider<RoomFormProvider>(
  (ref) => RoomFormProvider(),
);

class RoomFormProvider {
  RoomFormProvider();

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
