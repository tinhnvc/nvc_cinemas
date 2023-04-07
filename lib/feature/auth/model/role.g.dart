// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Role _$$_RoleFromJson(Map<String, dynamic> json) => _$_Role(
      roleId: json['roleId'] as String? ?? '',
      roleName: json['roleName'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
    );

Map<String, dynamic> _$$_RoleToJson(_$_Role instance) => <String, dynamic>{
      'roleId': instance.roleId,
      'roleName': instance.roleName,
      'title': instance.title,
      'description': instance.description,
    };
