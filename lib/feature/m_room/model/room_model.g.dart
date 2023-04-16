// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_RoomModel _$$_RoomModelFromJson(Map<String, dynamic> json) => _$_RoomModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      size: json['size'] as String?,
      seatAmount: json['seatAmount'] as int?,
      availableSeat: json['availableSeat'] as int?,
      active: json['active'] as bool? ?? true,
      createAt: json['createAt'] as int?,
      updateAt: json['updateAt'] as int?,
    );

Map<String, dynamic> _$$_RoomModelToJson(_$_RoomModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'size': instance.size,
      'seatAmount': instance.seatAmount,
      'availableSeat': instance.availableSeat,
      'active': instance.active,
      'createAt': instance.createAt,
      'updateAt': instance.updateAt,
    };
