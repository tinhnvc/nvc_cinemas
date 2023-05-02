import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/feature/m_room/model/room_model.dart';
import 'package:nvc_cinemas/feature/m_room/model/seat_model.dart';
import 'package:nvc_cinemas/feature/m_seat/model/seat_type_model.dart';
import 'package:nvc_cinemas/shared/link/rooms.dart';
import 'package:nvc_cinemas/shared/util/function_ulti.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:uuid/uuid.dart';

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

  void editMovie(RoomModel room) {
    state = [
      for (final item in state)
        if (item.id == room.id)
          item.copyWith(
            name: room.name,
            size: room.size,
            seatAmount: room.seatAmount,
            availableSeat: room.availableSeat,
            createAt: room.createAt,
            updateAt: room.updateAt,
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

final roomFormProvider = Provider<RoomFormProvider>(
  (ref) => RoomFormProvider(),
);

class RoomFormProvider {
  RoomFormProvider();

  final addRoomForm = FormGroup({
    'roomName': FormControl<String>(),
    'size': FormControl<String>(),
    'seatAmount': FormControl<String>(),
  });

  final buttonController = RoundedLoadingButtonController();

  Future<void> addRoom(WidgetRef ref, BuildContext context) async {
    buttonController.start();
    await Future.delayed(const Duration(milliseconds: 700));
    final height = ref.watch(heightAddRoomProvider);
    final width = ref.watch(widthAddRoomProvider);
    final roomName = addRoomForm.control('roomName').value;
    final size = '$height x $width';
    final seatAmount = addRoomForm.control('seatAmount').value;
    final room = RoomModel(
      id: ref.watch(roomIdProvider),
      name: roomName,
      size: size,
      seatAmount: int.parse(seatAmount),
      availableSeat: int.parse(seatAmount),
      active: true,
      createAt: DateTime.now().millisecondsSinceEpoch,
      updateAt: DateTime.now().millisecondsSinceEpoch,
    );
    ref.read(roomsProvider.notifier).add(room);
    FunctionUtil.alertPopUpCreated(onPressedConfirm: () {
      Navigator.pop(context);
    });
    buttonController.reset();
  }

  Future<void> editRoom(WidgetRef ref, BuildContext context) async {}

  Future<void> changeStatus(WidgetRef ref, BuildContext context) async {}
}

final widthAddRoomProvider =
    StateNotifierProvider<WidthAddRoomNotifier, String>(
  (ref) => WidthAddRoomNotifier(),
);

class WidthAddRoomNotifier extends StateNotifier<String> {
  WidthAddRoomNotifier() : super('4');

  void update(String value) {
    state = value;
  }
}

final heightAddRoomProvider =
    StateNotifierProvider<HeightAddRoomNotifier, String>(
  (ref) => HeightAddRoomNotifier(),
);

class HeightAddRoomNotifier extends StateNotifier<String> {
  HeightAddRoomNotifier() : super('3');

  void update(String value) {
    state = value;
  }
}

final roomIdProvider = StateNotifierProvider<RoomIdNotifier, String>(
  (ref) => RoomIdNotifier(),
);

class RoomIdNotifier extends StateNotifier<String> {
  RoomIdNotifier() : super(Uuid().v4());

  void update(String value) {
    state = value;
  }
}

final seatsAddRoomProvider =
    StateNotifierProvider<SeatsAddRoomNotifier, List<SeatModel>>(
  (ref) => SeatsAddRoomNotifier(),
);

class SeatsAddRoomNotifier extends StateNotifier<List<SeatModel>> {
  SeatsAddRoomNotifier() : super([]) {}

  Future<void> fetchRooms(WidgetRef ref, int height, int width) async {
    var rowList = [];
    var colList = [];
    var indexList = [];
    for (int i = 0; i < height; i++) {
      rowList.add(i + 1);
    }
    for (int i = 0; i < width; i++) {
      colList.add(i + 1);
    }
    for (int i = 0; i < height * width; i++) {
      indexList.add(i);
    }
    final seatsInit = <SeatModel>[];
    final roomId = ref.watch(roomIdProvider);
    for (final item in rowList) {
      for (final colItem in colList) {
        final seat = SeatModel(
          id: Uuid().v4(),
          position: '${rowSeatName(item)}$colItem',
          roomId: roomId,
          seatTypeId: '212c58aa-c7c1-4de8-b3c9-75103eca4a7e',
          isSelected: false,
          isSold: false,
          createAt: DateTime.now().millisecondsSinceEpoch,
          updateAt: DateTime.now().millisecondsSinceEpoch,
        );
        seatsInit.add(seat);
      }
    }
    state = seatsInit;
  }

  SeatModel getById(String id) {
    var seat = const SeatModel();
    if (state.isNotEmpty) {
      for (final item in state) {
        if (item.id == id) {
          seat = item;
        }
      }
    }

    return seat;
  }

  void add(SeatModel seat) {
    state = [...state, seat];
  }

  String rowSeatName(int row) {
    switch (row) {
      case 1:
        return 'A';
      case 2:
        return 'B';
      case 3:
        return 'C';
      case 4:
        return 'D';
      case 5:
        return 'E';
      case 6:
        return 'F';
      case 7:
        return 'G';
      case 8:
        return 'H';
      case 9:
        return 'I';
      case 10:
        return 'J';
      default:
        return 'A';
    }
  }
}
