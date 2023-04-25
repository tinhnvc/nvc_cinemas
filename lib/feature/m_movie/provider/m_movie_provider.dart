import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/feature/movie/model/movie_model.dart';
import 'package:nvc_cinemas/shared/link/movies.dart';
import 'package:nvc_cinemas/shared/util/function_ulti.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:uuid/uuid.dart';

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

  void moveCategoryToOther(String categoryId) {
    state = [
      for (final item in state)
        if (item.category == categoryId)
          item.copyWith(
            category: 'd44e5235-566c-46e0-a947-0df21794aafb',
          )
        else
          item,
    ];
  }

  void add(MovieModel movie) {
    state = [...state, movie];
  }

  void editMovie(MovieModel movie) {
    state = [
      for (final item in state)
        if (item.id == movie.id)
          item.copyWith(
            category: movie.category,
            movieNameVi: movie.movieNameVi,
            movieNameEn: movie.movieNameEn,
            image: movie.image,
            description: movie.description,
            duration: movie.duration,
            director: movie.director,
            actor: movie.actor,
            type: movie.type,
            dimension: movie.dimension,
            startTime: movie.startTime,
            endTime: movie.endTime,
            createAt: movie.createAt,
            updateAt: movie.updateAt,
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

final movieFormProvider = Provider<MovieFormProvider>(
  (ref) => MovieFormProvider(),
);

class MovieFormProvider {
  MovieFormProvider();

  final addMovieForm = FormGroup({
    'category': FormControl<String>(),
    'movieNameVi': FormControl<String>(),
    'movieNameEn': FormControl<String>(),
    'dimension': FormControl<String>(),
    'image': FormControl<String>(),
    'description': FormControl<String>(),
    'duration': FormControl<String>(),
    'director': FormControl<String>(),
    'actor': FormControl<String>(),
    'type': FormControl<String>(),
    'startTime': FormControl<String>(),
    'endTime': FormControl<String>(),
  });

  final buttonController = RoundedLoadingButtonController();

  Future<void> addMovie(WidgetRef ref, BuildContext context) async {
    buttonController.start();
    await Future.delayed(const Duration(milliseconds: 700));
    final category = addMovieForm.control('category').value;
    final movieNameVi = addMovieForm.control('movieNameVi').value;
    final movieNameEn = addMovieForm.control('movieNameEn').value;
    final image = addMovieForm.control('image').value;
    final description = addMovieForm.control('description').value;
    final duration = addMovieForm.control('duration').value;
    final director = addMovieForm.control('director').value;
    final actor = addMovieForm.control('actor').value;
    final type = addMovieForm.control('type').value;
    final startTime = addMovieForm.control('startTime').value;
    final endTime = addMovieForm.control('endTime').value;
    final movie = MovieModel(
      id: Uuid().v4(),
      category: category,
      movieNameVi: movieNameVi,
      movieNameEn: movieNameEn,
      image: image,
      description: description,
      duration: duration,
      director: director,
      actor: actor,
      type: type,
      startTime: int.parse(startTime),
      endTime: int.parse(endTime),
      active: true,
      createAt: DateTime.now().millisecondsSinceEpoch,
      updateAt: DateTime.now().millisecondsSinceEpoch,
    );
    ref.read(moviesProvider.notifier).add(movie);
    FunctionUtil.alertPopUpCreated(onPressedConfirm: () {
      Navigator.pop(context);
    });
    buttonController.reset();
  }

  Future<void> editMovie(
    WidgetRef ref,
    BuildContext context,
    MovieModel movieModel,
  ) async {
    buttonController.start();
    await Future.delayed(const Duration(milliseconds: 700));
    final category = addMovieForm.control('category').value;
    final movieNameVi = addMovieForm.control('movieNameVi').value;
    final movieNameEn = addMovieForm.control('movieNameEn').value;
    final image = addMovieForm.control('image').value;
    final description = addMovieForm.control('description').value;
    final duration = addMovieForm.control('duration').value;
    final director = addMovieForm.control('director').value;
    final actor = addMovieForm.control('actor').value;
    final type = addMovieForm.control('type').value;
    final dimension = addMovieForm.control('dimension').value;
    final startTime = addMovieForm.control('startTime').value;
    final endTime = addMovieForm.control('endTime').value;
    final movie = MovieModel(
      id: movieModel.id,
      category: category,
      movieNameVi: movieNameVi,
      movieNameEn: movieNameEn,
      image: image,
      description: description,
      duration: duration,
      director: director,
      actor: actor,
      type: type,
      dimension: dimension,
      startTime: int.parse(startTime),
      endTime: int.parse(endTime),
      createAt: movieModel.createAt,
      updateAt: DateTime.now().millisecondsSinceEpoch,
    );
    ref.read(moviesProvider.notifier).editMovie(movie);
    FunctionUtil.alertPopUpUpdated(onPressedConfirm: () {
      Navigator.pop(context);
    });
    buttonController.reset();
  }

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

final dimensionTypeAddMovieProvider =
    StateNotifierProvider<DimensionTypeAddMovieNotifier, String>(
  (ref) => DimensionTypeAddMovieNotifier(),
);

class DimensionTypeAddMovieNotifier extends StateNotifier<String> {
  DimensionTypeAddMovieNotifier() : super('');

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

final isSelectNowShowingProvider =
    StateNotifierProvider((ref) => IsSelectNowShowingNotifier());

class IsSelectNowShowingNotifier extends StateNotifier<bool> {
  IsSelectNowShowingNotifier() : super(true);

  set changed(bool value) => state = value;
}

final startTimeAddMovieProvider =
    StateNotifierProvider<StartTimeAddMovieNotifier, String>(
  (ref) => StartTimeAddMovieNotifier(),
);

class StartTimeAddMovieNotifier extends StateNotifier<String> {
  StartTimeAddMovieNotifier() : super('0');

  void update(String value) {
    state = value;
  }
}

final endTimeAddMovieProvider =
    StateNotifierProvider<EndTimeAddMovieNotifier, String>(
  (ref) => EndTimeAddMovieNotifier(),
);

class EndTimeAddMovieNotifier extends StateNotifier<String> {
  EndTimeAddMovieNotifier() : super('0');

  void update(String value) {
    state = value;
  }
}

final imageAddMovieProvider =
    StateNotifierProvider<ImageAddMovieNotifier, String>(
  (ref) => ImageAddMovieNotifier(),
);

class ImageAddMovieNotifier extends StateNotifier<String> {
  ImageAddMovieNotifier() : super('');

  void update(String value) {
    state = value;
  }
}
