import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/feature/m_movie/model/time_model.dart';
import 'package:nvc_cinemas/feature/m_room/model/seat_model.dart';
import 'package:nvc_cinemas/feature/ticket/provider/ticket_provider.dart';
import 'package:nvc_cinemas/shared/link/seats.dart';
import 'package:nvc_cinemas/shared/util/function_ulti.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

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

  void setSoldSeat(List<String> ids) {
    for (final seatId in ids) {
      state = [
        for (final item in state)
          if (item.id == seatId) item.copyWith(isSold: true) else item,
      ];
    }
  }

  void cleanStatus() {
    state = [
      for (final item in state) item.copyWith(isSelected: false),
    ];
  }

  void cleanStatusSold() {
    state = [
      for (final item in state) item.copyWith(isSold: false),
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

  String getSeatEmptyAmount(WidgetRef ref, TimeModel time) {
    var totalSeats = 0;
    for (final item in state) {
      if (item.roomId == time.roomId) {
        totalSeats += 1;
      }
    }
    final soldSeats =
        ref.read(ticketsProvider.notifier).getSeatsIdByTimeId(time.id!);
    return '${totalSeats - soldSeats.length}';
  }

  bool allowDeleteShowtime(WidgetRef ref, TimeModel time) {
    final soldSeats =
        ref.read(ticketsProvider.notifier).getSeatsIdByTimeId(time.id!);
    print(soldSeats);
    return soldSeats.length == 0;
  }
}
