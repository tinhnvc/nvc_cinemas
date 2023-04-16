import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/feature/movie/model/day_of_week_model.dart';
import 'package:nvc_cinemas/shared/service/date_service.dart';

final dayOfWeekProvider =
    StateNotifierProvider<MoviesNotifier, List<DayOfWeekModel>>(
  (ref) => MoviesNotifier(ref.read),
);

class MoviesNotifier extends StateNotifier<List<DayOfWeekModel>> {
  MoviesNotifier(this._reader) : super([]) {}

  final Reader _reader;

  Future<void> fetchDayOfWeek(WidgetRef ref, BuildContext context) async {
    final dayOfWeekFetch =
        daysOfWeekFromJson(DateService.dateRangeInWeek(ref, context));
    state = dayOfWeekFetch;
  }

  void cleanStatus() {
    state = [
      for (final item in state) item.copyWith(isSelected: false),
    ];
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

  void statusChangedDefault(String id) {
    cleanStatus();
    state = [
      for (final item in state)
        if (item.id == id) item.copyWith(isSelected: true) else item,
    ];
  }

  DayOfWeekModel getById(String id) {
    var dow = const DayOfWeekModel();
    if (state.isNotEmpty) {
      for (final item in state) {
        if (item.id == id) {
          dow = item;
        }
      }
    }
    return dow;
  }

  DayOfWeekModel getSelected() {
    var dow = const DayOfWeekModel();
    for (final item in state) {
      if (item.isSelected!) {
        dow = item;
      }
    }

    return dow;
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
    // cleanStatus();
  }
}
