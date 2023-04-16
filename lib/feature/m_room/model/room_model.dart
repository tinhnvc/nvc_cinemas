import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nvc_cinemas/feature/auth/model/role.dart';

part 'room_model.freezed.dart';

part 'room_model.g.dart';

List<RoomModel> roomsFromJson(List<dynamic> data) => List<RoomModel>.from(
    data.map((x) => RoomModel.fromJson(x as Map<String, dynamic>)));

RoomModel roomFromJson(String str) =>
    RoomModel.fromJson(json.decode(str) as Map<String, Object>);

@freezed
class RoomModel with _$RoomModel {
  const factory RoomModel({
    String? id,
    String? name,
    String? size,
    int? seatAmount,
    int? availableSeat,
    @Default(true) bool? active,
    int? createAt,
    int? updateAt,
  }) = _RoomModel;

  const RoomModel._();

  factory RoomModel.fromJson(Map<String, dynamic> json) =>
      _$RoomModelFromJson(json);
}
