import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nvc_cinemas/feature/auth/model/role.dart';

part 'time_model.freezed.dart';

part 'time_model.g.dart';

List<TimeModel> timesFromJson(List<dynamic> data) => List<TimeModel>.from(
    data.map((x) => TimeModel.fromJson(x as Map<String, dynamic>)));

TimeModel timeFromJson(String str) =>
    TimeModel.fromJson(json.decode(str) as Map<String, Object>);

@freezed
class TimeModel with _$TimeModel {
  const factory TimeModel({
    String? id,
    String? movieId,
    String? roomId,
    int? from,
    int? to,
  }) = _TimeModel;

  const TimeModel._();

  factory TimeModel.fromJson(Map<String, dynamic> json) =>
      _$TimeModelFromJson(json);
}
