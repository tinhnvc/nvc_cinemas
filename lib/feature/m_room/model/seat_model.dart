import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nvc_cinemas/feature/auth/model/role.dart';

part 'seat_model.freezed.dart';

part 'seat_model.g.dart';

List<SeatModel> seatsFromJson(List<dynamic> data) => List<SeatModel>.from(
    data.map((x) => SeatModel.fromJson(x as Map<String, dynamic>)));

SeatModel seatFromJson(String str) =>
    SeatModel.fromJson(json.decode(str) as Map<String, Object>);

@freezed
class SeatModel with _$SeatModel {
  const factory SeatModel({
    String? id,
    String? seatTypeId,
    String? roomId,
    String? position,
    int? createAt,
    int? updateAt,
    @Default(false) bool? isSold,
    @Default(false) bool? isSelected,
  }) = _SeatModel;

  const SeatModel._();

  factory SeatModel.fromJson(Map<String, dynamic> json) =>
      _$SeatModelFromJson(json);
}
