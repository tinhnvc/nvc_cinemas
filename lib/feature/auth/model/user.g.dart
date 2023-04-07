// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_User _$$_UserFromJson(Map<String, dynamic> json) => _$_User(
      userId: json['userId'] as String?,
      role: json['role'] == null
          ? null
          : Role.fromJson(json['role'] as Map<String, dynamic>),
      email: json['email'] as String?,
      password: json['password'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      fullName: json['fullName'] as String?,
      gender: json['gender'] as String?,
      yob: json['yob'] as String?,
      active: json['active'] as bool? ?? true,
      createAt: json['createAt'] as int?,
      updateAt: json['updateAt'] as int?,
      isSelected: json['isSelected'] as bool? ?? true,
    );

Map<String, dynamic> _$$_UserToJson(_$_User instance) => <String, dynamic>{
      'userId': instance.userId,
      'role': instance.role,
      'email': instance.email,
      'password': instance.password,
      'phoneNumber': instance.phoneNumber,
      'fullName': instance.fullName,
      'gender': instance.gender,
      'yob': instance.yob,
      'active': instance.active,
      'createAt': instance.createAt,
      'updateAt': instance.updateAt,
      'isSelected': instance.isSelected,
    };
