// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SeatModel _$$_SeatModelFromJson(Map<String, dynamic> json) => _$_SeatModel(
      id: json['id'] as String?,
      seatTypeId: json['seatTypeId'] as String?,
      roomId: json['roomId'] as String?,
      position: json['position'] as String?,
      createAt: json['createAt'] as int?,
      updateAt: json['updateAt'] as int?,
      isSold: json['isSold'] as bool? ?? false,
      isSelected: json['isSelected'] as bool? ?? false,
    );

Map<String, dynamic> _$$_SeatModelToJson(_$_SeatModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'seatTypeId': instance.seatTypeId,
      'roomId': instance.roomId,
      'position': instance.position,
      'createAt': instance.createAt,
      'updateAt': instance.updateAt,
      'isSold': instance.isSold,
      'isSelected': instance.isSelected,
    };
