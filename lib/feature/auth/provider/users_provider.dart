import 'package:nvc_cinemas/feature/auth/model/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/shared/link/users.dart';

final usersProvider = StateNotifierProvider<UsersNotifier, List<User>>(
  (ref) => UsersNotifier(),
);

class UsersNotifier extends StateNotifier<List<User>> {
  UsersNotifier() : super([]) {
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    final usersFetch = usersFromJson(users);
    state = usersFetch;
  }

  Future<void> refresh(WidgetRef ref) async {
    ref..refresh(usersProvider);

    return;
  }

  void add(User user) {
    state = [...state, user];
  }

  void cloneList(List<User> user) {
    state = [...user];
  }

  void remove(String userId) {
    state = [
      for (final item in state)
        if (item.userId != userId) item,
    ];
  }

  void cleanStatus() {
    state = [
      for (final item in state) item.copyWith(isSelected: false),
    ];
  }

  void statusChanged(String id) {
    state = [
      for (final item in state)
        if (item.userId == id)
          item.copyWith(isSelected: !item.isSelected!)
        else
          item,
    ];
  }

  void statusChangedDefault(String id) {
    cleanStatus();
    state = [
      for (final item in state)
        if (item.userId == id) item.copyWith(isSelected: true) else item,
    ];
  }

  void changePassword(String id, String password) {
    state = [
      for (final item in state)
        if (item.userId == id) item.copyWith(password: password) else item,
    ];
  }

  void onceSelect(String id) {
    if (!isSelected(id)) {
      cleanStatus();
      statusChanged(id);

      return;
    }
    cleanStatus();
  }

  User getById(String id) {
    var user = const User();
    if (state.isNotEmpty) {
      for (final item in state) {
        if (item.userId == id) {
          user = item;
        }
      }
    }

    return user;
  }

  User getSelected() {
    var user = const User(userId: '');
    for (final item in state) {
      if (item.isSelected!) {
        user = item;
      }
    }

    return user;
  }

  bool isSelected(String userId) {
    final userById = getById(userId).userId == getSelected().userId;

    return userById;
  }

  void editUser(User user) {
    state = [
      for (final item in state)
        if (item.userId == user.userId)
          item.copyWith(
            password: user.password,
            fullName: user.fullName,
            phoneNumber: user.phoneNumber,
            gender: user.gender,
            yob: user.yob,
            createAt: user.createAt,
            updateAt: user.updateAt,
          )
        else
          item,
    ];
  }

  void switchActive(String id, bool value) {
    state = [
      for (final item in state)
        if (item.userId == id)
          item.copyWith(
            active: value,
          )
        else
          item,
    ];
  }
}

final sortTypeFilterInternalContactProvider =
    StateNotifierProvider<SortTypeFilterInternalContactNotifier, String>(
  (ref) => SortTypeFilterInternalContactNotifier(),
);

class SortTypeFilterInternalContactNotifier extends StateNotifier<String> {
  SortTypeFilterInternalContactNotifier() : super('');

  void update(String value) {
    state = value;
  }
}
