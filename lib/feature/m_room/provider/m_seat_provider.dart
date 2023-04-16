import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/feature/m_room/model/seat_model.dart';
import 'package:nvc_cinemas/shared/link/seats.dart';

final seatsProvider = StateNotifierProvider<SeatsNotifier, List<SeatModel>>(
  (ref) => SeatsNotifier(),
);

class SeatsNotifier extends StateNotifier<List<SeatModel>> {
  SeatsNotifier() : super([]) {
    fetchSeats();
  }

  Future<void> fetchSeats() async {
    final seatsFetch = seatsFromJson(seats);
    state = seatsFetch;
  }

  void add(SeatModel seat) {
    state = [...state, seat];
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

  void statusChanged(String id) {
    state = [
      for (final item in state)
        if (item.id == id)
          item.copyWith(isSelected: !item.isSelected!)
        else
          item,
    ];
  }

  void cleanStatus() {
    state = [
      for (final item in state) item.copyWith(isSelected: false),
    ];
  }

  SeatModel getSelected() {
    var eat = const SeatModel();
    for (final item in state) {
      if (item.isSelected!) {
        eat = item;
      }
    }
    return eat;
  }

  bool isSelected(String id) {
    final userById = getById(id).id == getSelected().id;

    return userById;
  }

  void onceSelect(String id) {
    if (!isSelected(id)) {
      cleanStatus();
      statusChanged(id);
      return;
    }
    cleanStatus();
  }

  List<SeatModel> getByRoomId(String roomId) {
    var result = <SeatModel>[];
    if (state.isNotEmpty) {
      for (final item in state) {
        if (item.roomId == roomId) {
          result.add(item);
        }
      }
    }
    return result
      ..sort(
        (a, b) => a.position!.compareTo(b.position!),
      );
  }
}
