import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/feature/movie/model/movie_rating_model.dart';
import 'package:nvc_cinemas/shared/link/movie_ratings.dart';
import 'package:nvc_cinemas/shared/provider/user_provider.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

final movieRatingsProvider =
    StateNotifierProvider<MoviesNotifier, List<MovieRatingModel>>(
  (ref) => MoviesNotifier(),
);

class MoviesNotifier extends StateNotifier<List<MovieRatingModel>> {
  MoviesNotifier() : super([]) {
    fetchMovieRatings();
  }

  Future<void> fetchMovieRatings() async {
    final movieRatingsFetch = movieRatingsFromJson(movieRatings);
    state = movieRatingsFetch;
  }

  List<MovieRatingModel> getByMovieId(String id) {
    final result = <MovieRatingModel>[];
    if (state.isNotEmpty) {
      for (final item in state) {
        if (item.movieId == id) {
          result.add(item);
        }
      }
    }

    return result;
  }

  String sumRate(String movieId) {
    final comments = getByMovieId(movieId);
    double result = 0;
    if (comments.isNotEmpty) {
      for (final item in comments) {
        result += double.parse(item.star!);
      }
      result = result / comments.length;
    } else {
      return '0';
    }

    return result != 0 ? result.toStringAsFixed(1) : '0';
  }

  bool isComment(WidgetRef ref, String movieId) {
    final comments = getByMovieId(movieId);
    final user = ref.watch(userProvider);
    if (comments.isNotEmpty) {
      for (final item in comments) {
        if (item.userId == user.userId) {
          return true;
        }
      }
    }
    return false;
  }

  void add(MovieRatingModel rating) {
    state = [...state, rating];
  }
}

final movieRatingFormProvider = Provider<MovieRatingFormProvider>(
  (ref) => MovieRatingFormProvider(),
);

class MovieRatingFormProvider {
  MovieRatingFormProvider();

  final addCommentForm = FormGroup({
    'userId': FormControl<String>(),
    'movieId': FormControl<String>(),
    'star': FormControl<String>(),
    'comment': FormControl<String>(),
  });

  final buttonController = RoundedLoadingButtonController();

  Future<void> addComment(WidgetRef ref, BuildContext context) async {
    buttonController.start();
    await Future.delayed(const Duration(milliseconds: 700));

    final userId = addCommentForm.control('userId').value;
    final movieId = addCommentForm.control('movieId').value;
    final star = addCommentForm.control('star').value;
    final comment = addCommentForm.control('comment').value;

    final rating = MovieRatingModel(
      userId: userId,
      movieId: movieId,
      star: star,
      comment: comment,
      createAt: DateTime.now().millisecondsSinceEpoch,
    );

    ref.read(movieRatingsProvider.notifier).add(rating);
    buttonController.reset();
    Navigator.pop(context);
  }
}
