import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/feature/m_movie/model/time_model.dart';
import 'package:nvc_cinemas/feature/m_movie/provider/m_movie_provider.dart';
import 'package:nvc_cinemas/feature/movie/model/movie_model.dart';
import 'package:nvc_cinemas/feature/movie/provider/day_of_week_provider.dart';
import 'package:nvc_cinemas/shared/link/times.dart';
import 'package:nvc_cinemas/shared/util/function_ulti.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

final timesProvider = StateNotifierProvider<MoviesNotifier, List<TimeModel>>(
  (ref) => MoviesNotifier(),
);

class MoviesNotifier extends StateNotifier<List<TimeModel>> {
  MoviesNotifier() : super([]) {
    fetchTimes();
  }

  Future<void> fetchTimes() async {
    final timesFetch = timesFromJson(times);
    state = timesFetch;
  }

  List<TimeModel> getByDay({
    required WidgetRef ref,
    required String movieId,
  }) {
    var result = <TimeModel>[];
    final dow = ref.read(dayOfWeekProvider.notifier).getSelected();
    final movie = ref.read(moviesProvider.notifier).getById(movieId);
    if (dow.id != null) {
      final startTime = dow.day;
      final endTime = DateTime.fromMillisecondsSinceEpoch(dow.day!)
          .add(const Duration(days: 1))
          .millisecondsSinceEpoch;
      for (final item in state) {
        if (item.movieId == movieId &&
            item.from! > startTime! &&
            item.to! < endTime &&
            item.from! > DateTime.now().millisecondsSinceEpoch) {
          result.add(item);
        }
      }
    }
    return result..sort((a, b) => a.from!.compareTo(b.from!));
  }

  Set<MovieModel> getMovieByDay(WidgetRef ref, int startTime) {
    final result = <MovieModel>{};
    final timeOfDay = <TimeModel>[];
    final endTimeOfDay = DateTime.fromMillisecondsSinceEpoch(startTime)
        .add(const Duration(days: 1))
        .millisecondsSinceEpoch;
    for (final item in state) {
      if (item.from! > startTime &&
          item.from! < endTimeOfDay &&
          item.from! > DateTime.now().millisecondsSinceEpoch) {
        timeOfDay.add(item);
      }
    }
    if (timeOfDay.isNotEmpty) {
      for (final item in timeOfDay) {
        final movieById =
            ref.read(moviesProvider.notifier).getById(item.movieId!);
        result.add(movieById);
      }
    }

    return result;
  }

  TimeModel getById(String id) {
    var time = const TimeModel();
    if (state.isNotEmpty) {
      for (final item in state) {
        if (item.id == id) {
          time = item;
        }
      }
    }

    return time;
  }
}

final timeFormProvider = Provider<TimeFormProvider>(
  (ref) => TimeFormProvider(),
);

class TimeFormProvider {
  TimeFormProvider();

  final addShowtimeForm = FormGroup({
    'movieId': FormControl<String>(),
    'roomId': FormControl<String>(),
    'from': FormControl<String>(),
    'to': FormControl<String>(),
  });

  final buttonController = RoundedLoadingButtonController();

  Future<void> addShowtime(
    WidgetRef ref,
    BuildContext context,
  ) async {
    buttonController.start();
    await Future.delayed(const Duration(milliseconds: 700));
    FunctionUtil.alertPopUpConfirm(
        onPressedConfirm: () {
          Navigator.pop(context);
        },
        type: AlertType.success,
        title: 'Thành công',
        desc: 'Thêm lịch chiếu thành công');
    buttonController.reset();
  }
}

final startTimeAddShowtimeProvider =
    StateNotifierProvider<StartTimeAddShowtimeNotifier, String>(
  (ref) => StartTimeAddShowtimeNotifier(),
);

class StartTimeAddShowtimeNotifier extends StateNotifier<String> {
  StartTimeAddShowtimeNotifier() : super('0');

  void update(String value) {
    state = value;
  }
}

final endTimeAddShowtimeProvider =
    StateNotifierProvider<EndTimeAddShowtimeNotifier, String>(
  (ref) => EndTimeAddShowtimeNotifier(),
);

class EndTimeAddShowtimeNotifier extends StateNotifier<String> {
  EndTimeAddShowtimeNotifier() : super('0');

  void update(String value) {
    state = value;
  }
}
