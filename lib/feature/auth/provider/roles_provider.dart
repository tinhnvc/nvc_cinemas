import 'package:nvc_cinemas/feature/auth/model/role.dart';
import 'package:nvc_cinemas/feature/auth/model/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/shared/link/roles.dart';
import 'package:nvc_cinemas/shared/link/users.dart';

final rolesProvider = StateNotifierProvider<RolesNotifier, List<Role>>(
  (ref) => RolesNotifier(),
);

class RolesNotifier extends StateNotifier<List<Role>> {
  RolesNotifier() : super([]) {
    fetchRoles();
  }

  Future<void> fetchRoles() async {
    final rolesFetch = rolesFromJson(roles);
    state = rolesFetch;
  }

  void cloneList(List<Role> role) {
    state = [...role];
  }

  void remove(String roleId) {
    state = [
      for (final item in state)
        if (item.roleId != roleId) item,
    ];
  }

  Role getById(String id) {
    var role = const Role();
    if (state.isNotEmpty) {
      for (final item in state) {
        if (item.roleId == id) {
          role = item;
        }
      }
    }

    return role;
  }

  Role getByName(String roleTitle) {
    var role = const Role();
    if (state.isNotEmpty) {
      for (final item in state) {
        if (item.title == roleTitle) {
          role = item;
        }
      }
    }

    return role;
  }
}
