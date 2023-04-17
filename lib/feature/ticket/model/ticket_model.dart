import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nvc_cinemas/feature/auth/model/role.dart';

part 'ticket_model.freezed.dart';

part 'ticket_model.g.dart';

List<TicketModel> ticketsFromJson(List<dynamic> data) => List<TicketModel>.from(
    data.map((x) => TicketModel.fromJson(x as Map<String, dynamic>)));

TicketModel ticketFromJson(String str) =>
    TicketModel.fromJson(json.decode(str) as Map<String, Object>);

@freezed
class TicketModel with _$TicketModel {
  const factory TicketModel({
    String? id,
    String? userId,
    String? timeId,
    String? seatId,
    String? status,
    int? discount,
    int? totalPrice,
    int? createAt,
    int? updateAt,
  }) = _TicketModel;

  const TicketModel._();

  factory TicketModel.fromJson(Map<String, dynamic> json) =>
      _$TicketModelFromJson(json);
}
