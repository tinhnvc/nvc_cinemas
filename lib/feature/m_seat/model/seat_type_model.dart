import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nvc_cinemas/feature/auth/model/role.dart';

part 'seat_type_model.freezed.dart';

part 'seat_type_model.g.dart';

List<SeatTypeModel> seatTypesFromJson(List<dynamic> data) =>
    List<SeatTypeModel>.from(
        data.map((x) => SeatTypeModel.fromJson(x as Map<String, dynamic>)));

SeatTypeModel seatTypeFromJson(String str) =>
    SeatTypeModel.fromJson(json.decode(str) as Map<String, Object>);

@freezed
class SeatTypeModel with _$SeatTypeModel {
  const factory SeatTypeModel({
    String? id,
    String? typeName,
    int? price,
    int? otherPrice,
    @Default(true) bool? active,
    @Default(false) bool? isDefault,
    int? createAt,
    int? updateAt,
  }) = _SeatTypeModel;

  const SeatTypeModel._();

  factory SeatTypeModel.fromJson(Map<String, dynamic> json) =>
      _$SeatTypeModelFromJson(json);
}
