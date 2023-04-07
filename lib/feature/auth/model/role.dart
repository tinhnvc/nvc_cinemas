import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'role.freezed.dart';

part 'role.g.dart';

List<Role> rolesFromJson(List<dynamic> data) =>
    List<Role>.from(data.map((x) => Role.fromJson(x as Map<String, dynamic>)));

Role roleFromJson(String str) =>
    Role.fromJson(json.decode(str) as Map<String, Object>);

@freezed
class Role with _$Role {
  const factory Role({
    @Default('') String? roleId,
    @Default('') String? roleName,
    @Default('') String? title,
    @Default('') String? description,
  }) = _Role;

  const Role._();

  factory Role.fromJson(Map<String, dynamic> json) => _$RoleFromJson(json);
}
