import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nvc_cinemas/feature/auth/model/role.dart';

part 'user.freezed.dart';

part 'user.g.dart';

List<User> usersFromJson(List<dynamic> data) =>
    List<User>.from(data.map((x) => User.fromJson(x as Map<String, dynamic>)));

User userFromJson(String str) =>
    User.fromJson(json.decode(str) as Map<String, Object>);

@freezed
class User with _$User {
  const factory User({
    String? userId,
    Role? role,
    String? email,
    String? password,
    String? phoneNumber,
    String? fullName,
    String? gender,
    String? yob,
    @Default(true) bool? active,
    int? createAt,
    int? updateAt,
    @Default(true) bool? isSelected,
  }) = _User;

  const User._();

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
