import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/feature/movie/model/movie_model.dart';
import 'package:nvc_cinemas/shared/link/movies.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

final moviesProvider = StateNotifierProvider<MoviesNotifier, List<MovieModel>>(
  (ref) => MoviesNotifier(),
);

class MoviesNotifier extends StateNotifier<List<MovieModel>> {
  MoviesNotifier() : super([]) {
    fetchMovies();
  }

  Future<void> fetchMovies() async {
    final moviesFetch = moviesFromJson(movies);
    state = moviesFetch;
  }

  void cloneList(List<MovieModel> movies) {
    state = [...movies];
  }

  MovieModel getById(String id) {
    var movie = const MovieModel();
    if (state.isNotEmpty) {
      for (final item in state) {
        if (item.id == id) {
          movie = item;
        }
      }
    }

    return movie;
  }
}

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
