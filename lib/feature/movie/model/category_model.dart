import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nvc_cinemas/feature/auth/model/role.dart';

part 'category_model.freezed.dart';

part 'category_model.g.dart';

List<CategoryModel> categoriesFromJson(List<dynamic> data) =>
    List<CategoryModel>.from(
        data.map((x) => CategoryModel.fromJson(x as Map<String, dynamic>)));

CategoryModel categoryFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str) as Map<String, Object>);

@freezed
class CategoryModel with _$CategoryModel {
  const factory CategoryModel({
    String? id,
    String? categoryName,
    String? categoryNameEn,
    String? description,
    @Default(true) bool? active,
    int? createAt,
    int? updateAt,
  }) = _CategoryModel;

  const CategoryModel._();

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);
}
