// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CategoryModel _$$_CategoryModelFromJson(Map<String, dynamic> json) =>
    _$_CategoryModel(
      id: json['id'] as String?,
      categoryName: json['categoryName'] as String?,
      categoryNameEn: json['categoryNameEn'] as String?,
      description: json['description'] as String?,
      active: json['active'] as bool? ?? true,
      createAt: json['createAt'] as int?,
      updateAt: json['updateAt'] as int?,
      isSelected: json['isSelected'] as bool? ?? true,
    );

Map<String, dynamic> _$$_CategoryModelToJson(_$_CategoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'categoryName': instance.categoryName,
      'categoryNameEn': instance.categoryNameEn,
      'description': instance.description,
      'active': instance.active,
      'createAt': instance.createAt,
      'updateAt': instance.updateAt,
      'isSelected': instance.isSelected,
    };
