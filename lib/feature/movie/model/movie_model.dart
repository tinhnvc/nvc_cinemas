import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nvc_cinemas/feature/auth/model/role.dart';
import 'package:nvc_cinemas/feature/movie/model/category_model.dart';

part 'movie_model.freezed.dart';

part 'movie_model.g.dart';

List<MovieModel> moviesFromJson(List<dynamic> data) => List<MovieModel>.from(
    data.map((x) => MovieModel.fromJson(x as Map<String, dynamic>)));

MovieModel movieFromJson(String str) =>
    MovieModel.fromJson(json.decode(str) as Map<String, Object>);

@freezed
class MovieModel with _$MovieModel {
  const factory MovieModel({
    String? id,
    String? category,
    String? movieNameVi,
    String? movieNameEn,
    String? image,
    String? description,
    String? duration,
    String? director,
    String? actor,
    String? type,
    String? dimension,
    @Default(true) bool? active,
    int? startTime,
    int? endTime,
    int? createAt,
    int? updateAt,
  }) = _MovieModel;

  const MovieModel._();

  factory MovieModel.fromJson(Map<String, dynamic> json) =>
      _$MovieModelFromJson(json);
}
