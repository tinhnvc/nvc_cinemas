// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promotion_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PromotionModel _$$_PromotionModelFromJson(Map<String, dynamic> json) =>
    _$_PromotionModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      content: json['content'] as String?,
      image: json['image'] as String?,
      code: json['code'] as String?,
      active: json['active'] as bool? ?? true,
      startTime: json['startTime'] as int?,
      endTime: json['endTime'] as int?,
      createAt: json['createAt'] as int?,
      updateAt: json['updateAt'] as int?,
    );

Map<String, dynamic> _$$_PromotionModelToJson(_$_PromotionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'content': instance.content,
      'image': instance.image,
      'code': instance.code,
      'active': instance.active,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'createAt': instance.createAt,
      'updateAt': instance.updateAt,
    };
