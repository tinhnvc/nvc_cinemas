import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie_rating_model.freezed.dart';

part 'movie_rating_model.g.dart';

List<MovieRatingModel> movieRatingsFromJson(List<dynamic> data) =>
    List<MovieRatingModel>.from(
        data.map((x) => MovieRatingModel.fromJson(x as Map<String, dynamic>)));

MovieRatingModel movieRatingFromJson(String str) =>
    MovieRatingModel.fromJson(json.decode(str) as Map<String, Object>);

@freezed
class MovieRatingModel with _$MovieRatingModel {
  const factory MovieRatingModel({
    String? userId,
    String? movieId,
    String? star,
    String? comment,
    int? createAt,
  }) = _MovieRatingModel;

  const MovieRatingModel._();

  factory MovieRatingModel.fromJson(Map<String, dynamic> json) =>
      _$MovieRatingModelFromJson(json);
}
