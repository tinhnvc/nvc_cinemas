// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seat_type_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SeatTypeModel _$$_SeatTypeModelFromJson(Map<String, dynamic> json) =>
    _$_SeatTypeModel(
      id: json['id'] as String?,
      typeName: json['typeName'] as String?,
      price: json['price'] as int?,
      otherPrice: json['otherPrice'] as int?,
      active: json['active'] as bool? ?? true,
      isDefault: json['isDefault'] as bool? ?? true,
      createAt: json['createAt'] as int?,
      updateAt: json['updateAt'] as int?,
    );

Map<String, dynamic> _$$_SeatTypeModelToJson(_$_SeatTypeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typeName': instance.typeName,
      'price': instance.price,
      'otherPrice': instance.otherPrice,
      'active': instance.active,
      'isDefault': instance.isDefault,
      'createAt': instance.createAt,
      'updateAt': instance.updateAt,
    };
