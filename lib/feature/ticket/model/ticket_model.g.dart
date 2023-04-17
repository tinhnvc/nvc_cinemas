// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TicketModel _$$_TicketModelFromJson(Map<String, dynamic> json) =>
    _$_TicketModel(
      id: json['id'] as String?,
      userId: json['userId'] as String?,
      timeId: json['timeId'] as String?,
      seatId: json['seatId'] as String?,
      status: json['status'] as String?,
      discount: json['discount'] as int?,
      totalPrice: json['totalPrice'] as int?,
      createAt: json['createAt'] as int?,
      updateAt: json['updateAt'] as int?,
    );

Map<String, dynamic> _$$_TicketModelToJson(_$_TicketModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'timeId': instance.timeId,
      'seatId': instance.seatId,
      'status': instance.status,
      'discount': instance.discount,
      'totalPrice': instance.totalPrice,
      'createAt': instance.createAt,
      'updateAt': instance.updateAt,
    };
