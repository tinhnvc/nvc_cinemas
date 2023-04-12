import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

final movieFormProvider = Provider<MovieFormProvider>(
  (ref) => MovieFormProvider(),
);

class MovieFormProvider {
  MovieFormProvider();

  final addMovieForm = FormGroup({
    'category': FormControl<String>(),
    'movieNameVi': FormControl<String>(),
    'movieNameEn': FormControl<String>(),
    'image': FormControl<String>(),
    'description': FormControl<String>(),
    'duration': FormControl<String>(),
    'production': FormControl<String>(),
    'director': FormControl<String>(),
    'actor': FormControl<String>(),
    'type': FormControl<String>(),
    'startTime': FormControl<String>(),
    'endTime': FormControl<String>(),
  });

  final buttonController = RoundedLoadingButtonController();

  Future<void> addMovie(WidgetRef ref, BuildContext context) async {}

  Future<void> editMovie(WidgetRef ref, BuildContext context) async {}

  Future<void> changeStatus(WidgetRef ref, BuildContext context) async {}
}

final categoryAddMovieProvider =
    StateNotifierProvider<CategoryAddMovieNotifier, String>(
  (ref) => CategoryAddMovieNotifier(),
);

class CategoryAddMovieNotifier extends StateNotifier<String> {
  CategoryAddMovieNotifier() : super('');

  void update(String value) {
    state = value;
  }
}

final ageTypeAddMovieProvider =
    StateNotifierProvider<AgeTypeAddMovieNotifier, String>(
  (ref) => AgeTypeAddMovieNotifier(),
);

class AgeTypeAddMovieNotifier extends StateNotifier<String> {
  AgeTypeAddMovieNotifier() : super('');

  void update(String value) {
    state = value;
  }
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
