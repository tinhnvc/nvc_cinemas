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
import 'package:uuid/uuid.dart';

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

  void add(TimeModel time) {
    state = [...state, time];
  }

  void remove(String timeId) {
    state = [
      for (final item in state)
        if (item.id != timeId) item,
    ];
  }

  void editTime(TimeModel time) {
    state = [
      for (final item in state)
        if (item.id == time.id)
          item.copyWith(
            roomId: time.roomId,
            from: time.from,
            to: time.to,
          )
        else
          item,
    ];
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

  List<TimeModel> getByDayFromSource({
    required WidgetRef ref,
    required String movieId,
    required List<TimeModel> times,
  }) {
    var result = <TimeModel>[];
    final dow = ref.read(dayOfWeekProvider.notifier).getSelected();
    final movie = ref.read(moviesProvider.notifier).getById(movieId);
    if (dow.id != null) {
      final startTime = dow.day;
      final endTime = DateTime.fromMillisecondsSinceEpoch(dow.day!)
          .add(const Duration(days: 1))
          .millisecondsSinceEpoch;
      for (final item in times) {
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

  bool checkShowtime(List<TimeModel> times, int from, int to) {
    var result = true;
    if (times.isNotEmpty) {
      for (final item in times) {
        if (from > item.from! && from < item.to!) {
          return false;
        }

        if (from < item.from! && to > item.from!) {
          return false;
        }

        if (from < item.from! && to > item.to!) {
          return false;
        }
      }
    } else {
      return true;
    }

    return result;
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
    MovieModel movie,
  ) async {
    buttonController.start();
    await Future.delayed(const Duration(milliseconds: 700));
    final roomId = addShowtimeForm.control('roomId').value;
    final from = addShowtimeForm.control('from').value;
    final to = addShowtimeForm.control('to').value;
    final time = TimeModel(
      id: Uuid().v4(),
      movieId: movie.id,
      roomId: roomId,
      from: int.parse(from),
      to: int.parse(to),
    );
    ref.read(timesProvider.notifier).add(time);
    FunctionUtil.alertPopUpConfirm(
        onPressedConfirm: () {
          Navigator.pop(context);
        },
        isConfirm: true,
        type: AlertType.success,
        title: 'Thành công',
        desc: 'Thêm lịch chiếu thành công');
    buttonController.reset();
  }

  Future<void> editShowtime(
    WidgetRef ref,
    BuildContext context,
    MovieModel movie,
    TimeModel timeModel,
  ) async {
    buttonController.start();
    await Future.delayed(const Duration(milliseconds: 700));
    final roomId = addShowtimeForm.control('roomId').value;
    final from = addShowtimeForm.control('from').value;
    final to = addShowtimeForm.control('to').value;
    final time = TimeModel(
      id: timeModel.id!,
      movieId: movie.id,
      roomId: roomId,
      from: int.parse(from),
      to: int.parse(to),
    );
    ref.read(timesProvider.notifier).editTime(time);
    FunctionUtil.alertPopUpConfirm(
        onPressedConfirm: () {
          Navigator.pop(context);
        },
        isConfirm: true,
        type: AlertType.success,
        title: 'Thành công',
        desc: 'Cập nhật lịch chiếu thành công');
    buttonController.reset();
  }

  Future<void> deleteShowtime(
    WidgetRef ref,
    BuildContext context,
    TimeModel timeModel,
  ) async {
    ref.read(timesProvider.notifier).remove(timeModel.id!);
    // FunctionUtil.alertPopUpConfirm(
    //     onPressedConfirm: () {},
    //     isConfirm: true,
    //     type: AlertType.success,
    //     title: 'Thành công',
    //     desc: 'Gỡ bỏ lịch chiếu thành công');
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

final isShowtimeAvailableProvider =
    StateNotifierProvider((ref) => IsShowtimeAvailableNotifier());

class IsShowtimeAvailableNotifier extends StateNotifier<bool> {
  IsShowtimeAvailableNotifier() : super(false);

  set changed(bool value) => state = value;
}
