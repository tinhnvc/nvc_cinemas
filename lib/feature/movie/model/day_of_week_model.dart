import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nvc_cinemas/feature/auth/model/role.dart';

part 'day_of_week_model.freezed.dart';

part 'day_of_week_model.g.dart';

List<DayOfWeekModel> daysOfWeekFromJson(List<dynamic> data) =>
    List<DayOfWeekModel>.from(
        data.map((x) => DayOfWeekModel.fromJson(x as Map<String, dynamic>)));

DayOfWeekModel dayOfWeekFromJson(String str) =>
    DayOfWeekModel.fromJson(json.decode(str) as Map<String, Object>);

@freezed
class DayOfWeekModel with _$DayOfWeekModel {
  const factory DayOfWeekModel({
    String? id,
    int? day,
    String? dayOfWeek,
    @Default(false) bool? isSelected,
  }) = _DayOfWeekModel;

  const DayOfWeekModel._();

  factory DayOfWeekModel.fromJson(Map<String, dynamic> json) =>
      _$DayOfWeekModelFromJson(json);
}
