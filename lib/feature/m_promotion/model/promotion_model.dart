import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nvc_cinemas/feature/auth/model/role.dart';
import 'package:nvc_cinemas/feature/movie/model/category_model.dart';

part 'promotion_model.freezed.dart';

part 'promotion_model.g.dart';

List<PromotionModel> promotionsFromJson(List<dynamic> data) =>
    List<PromotionModel>.from(
        data.map((x) => PromotionModel.fromJson(x as Map<String, dynamic>)));

PromotionModel promotionFromJson(String str) =>
    PromotionModel.fromJson(json.decode(str) as Map<String, Object>);

@freezed
class PromotionModel with _$PromotionModel {
  const factory PromotionModel({
    String? id,
    String? name,
    String? content,
    String? image,
    String? code,
    @Default(true) bool? active,
    int? startTime,
    int? endTime,
    int? createAt,
    int? updateAt,
  }) = _PromotionModel;

  const PromotionModel._();

  factory PromotionModel.fromJson(Map<String, dynamic> json) =>
      _$PromotionModelFromJson(json);
}
