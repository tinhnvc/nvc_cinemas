import 'package:nvc_cinemas/feature/auth/model/role.dart';
import 'package:nvc_cinemas/feature/auth/model/user.dart';
import 'package:nvc_cinemas/feature/auth/provider/users_provider.dart';
import 'package:nvc_cinemas/l10n/l10n.dart';
import 'package:nvc_cinemas/shared/model/profile.dart';
import 'package:nvc_cinemas/shared/repository/language_repository.dart';
import 'package:nvc_cinemas/shared/repository/profile_repository.dart';
import 'package:nvc_cinemas/shared/repository/token_repository.dart';
import 'package:nvc_cinemas/shared/util/function_ulti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:one_context/one_context.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:uuid/uuid.dart';

final userProvider = StateNotifierProvider<UserNotifier, User>(
  (ref) => UserNotifier(),
);

class UserNotifier extends StateNotifier<User> {
  UserNotifier() : super(const User()) {
    fetchUser(User());
  }

  Future<void> fetchUser(User user) async {
    state = user;
  }

  void editUser(User user) {
    state = state.copyWith(
      password: user.password,
      fullName: user.fullName,
      phoneNumber: user.phoneNumber,
      gender: user.gender,
      yob: user.yob,
      createAt: user.createAt,
      updateAt: user.updateAt,
    );
  }

  String? getNameCharacter() {
    final words = state.fullName?.split(' ');

    return words?.last.substring(0, 1);
  }

  String getSortName() {
    final name = state.fullName!.trim();
    final words = name.split(' ');
    final length = words.length;

    final sortName = StringBuffer();

    if (length <= 2) {
      for (final item in words) {
        sortName.write(item.substring(0, 1).toUpperCase());
      }
    } else {
      sortName
        ..write(words[0].substring(0, 1).toUpperCase())
        ..write(words[length - 1].substring(0, 1).toUpperCase());
    }

    return sortName.toString();
  }
}

final userFormProvider = Provider<UserFormProvider>(
  (ref) => UserFormProvider(),
);

class UserFormProvider {
  UserFormProvider();

  final addAccountForm = FormGroup({
    'email': FormControl<String>(),
    'password': FormControl<String>(),
    'fullName': FormControl<String>(),
    'phoneNumber': FormControl<String>(),
    'gender': FormControl<String>(),
    'yob': FormControl<String>(),
  });

  final editProfileForm = FormGroup({
    'password': FormControl<String>(),
    'fullName': FormControl<String>(),
    'phoneNumber': FormControl<String>(),
    'gender': FormControl<String>(),
    'yob': FormControl<String>(),
  });

  final editPasswordForm = FormGroup({
    'oldPassword': FormControl<String>(),
    'password': FormControl<String>(),
    'rePassword': FormControl<String>(),
  });

  final rateMovieForm = FormGroup({
    'star': FormControl<String>(),
    'comment': FormControl<String>(),
  });

  final buttonController = RoundedLoadingButtonController();

  Future<void> updateProfile(WidgetRef ref, BuildContext context) async {}

  Future<void> addAccount(WidgetRef ref, BuildContext context) async {
    buttonController.start();
    await Future.delayed(const Duration(milliseconds: 700));
    final email = addAccountForm.control('email').value;
    final password = addAccountForm.control('password').value;
    final fullName = addAccountForm.control('fullName').value;
    final phoneNumber = addAccountForm.control('phoneNumber').value;
    final gender = addAccountForm.control('gender').value;
    final yob = addAccountForm.control('yob').value;
    final role = ref.watch(roleModelAddAccountProvider);
    final user = User(
      userId: Uuid().v4(),
      email: email,
      password: password,
      fullName: fullName,
      phoneNumber: phoneNumber,
      gender: gender,
      yob: yob,
      role: role,
      active: true,
      createAt: DateTime.now().millisecondsSinceEpoch,
      updateAt: DateTime.now().millisecondsSinceEpoch,
    );
    ref.read(usersProvider.notifier).add(user);
    FunctionUtil.alertPopUpCreated(onPressedConfirm: () {
      Navigator.pop(context);
    });
    buttonController.reset();
  }

  Future<void> editAccount(
    WidgetRef ref,
    BuildContext context,
    User userModel,
  ) async {
    buttonController.start();
    await Future.delayed(const Duration(milliseconds: 700));
    final password = addAccountForm.control('password').value;
    final fullName = addAccountForm.control('fullName').value;
    final phoneNumber = addAccountForm.control('phoneNumber').value;
    final gender = addAccountForm.control('gender').value;
    final yob = addAccountForm.control('yob').value;
    final user = User(
      userId: userModel.userId,
      password: password,
      fullName: fullName,
      phoneNumber: phoneNumber,
      gender: gender,
      yob: yob,
      createAt: userModel.createAt,
      updateAt: DateTime.now().millisecondsSinceEpoch,
    );
    ref.read(usersProvider.notifier).editUser(user);
    FunctionUtil.alertPopUpUpdated(onPressedConfirm: () {
      Navigator.pop(context);
    });
    buttonController.reset();
  }

  Future<void> editCustomerInfo(
    WidgetRef ref,
    BuildContext context,
    User userModel,
  ) async {
    buttonController.start();
    await Future.delayed(const Duration(milliseconds: 700));
    final password = editProfileForm.control('password').value;
    final fullName = editProfileForm.control('fullName').value;
    final phoneNumber = editProfileForm.control('phoneNumber').value;
    final gender = editProfileForm.control('gender').value;
    final yob = editProfileForm.control('yob').value;
    final user = User(
      userId: userModel.userId,
      password: password,
      fullName: fullName,
      phoneNumber: phoneNumber,
      gender: gender,
      yob: yob,
      createAt: userModel.createAt,
      updateAt: DateTime.now().millisecondsSinceEpoch,
    );
    ref.read(usersProvider.notifier).editUser(user);
    ref.read(userProvider.notifier).editUser(user);
    FunctionUtil.alertPopUpUpdated(onPressedConfirm: () {
      Navigator.pop(context);
    });
    buttonController.reset();
  }

  Future<void> changePassword(
    WidgetRef ref,
    BuildContext context,
    User userModel,
  ) async {
    buttonController.start();
    await Future.delayed(const Duration(milliseconds: 700));
    final oldPassword = editPasswordForm.control('oldPassword').value;
    final password = editPasswordForm.control('password').value;
    final fullName = editProfileForm.control('fullName').value;
    final phoneNumber = editProfileForm.control('phoneNumber').value;
    final gender = editProfileForm.control('gender').value;
    final yob = editProfileForm.control('yob').value;
    if (userModel.password != oldPassword) {
      editPasswordForm
          .control('oldPassword')
          .setErrors({'Mật khẩu cũ không đúng': true});

      buttonController.reset();
      return;
    }

    final user = User(
      userId: userModel.userId,
      password: password,
      fullName: fullName,
      phoneNumber: phoneNumber,
      gender: gender,
      yob: yob,
      createAt: userModel.createAt,
      updateAt: DateTime.now().millisecondsSinceEpoch,
    );
    ref.read(usersProvider.notifier).editUser(user);
    ref.read(userProvider.notifier).editUser(user);
    FunctionUtil.alertPopUpUpdated(onPressedConfirm: () {
      Navigator.pop(context);
    });
    buttonController.reset();
  }

  Future<void> updatePassword(WidgetRef ref, BuildContext context) async {
    buttonController.start();
    FunctionUtil.alertPopUpConfirm(
      onPressedConfirm: () {},
      isConfirm: true,
      type: AlertType.success,
      title: context.l10n.resetSuccess,
      desc: '',
    );
    await OneContext().pushReplacementNamed('/sign-in');
  }
}

final isSecureOldPasswordProvider =
    StateNotifierProvider((ref) => IsSecureOldPasswordNotifier());

class IsSecureOldPasswordNotifier extends StateNotifier<bool> {
  IsSecureOldPasswordNotifier() : super(true);

  set changed(bool value) => state = value;
}

final isSecureNewPasswordProvider =
    StateNotifierProvider((ref) => IsSecureNewPasswordNotifier());

class IsSecureNewPasswordNotifier extends StateNotifier<bool> {
  IsSecureNewPasswordNotifier() : super(true);

  set changed(bool value) => state = value;
}

final isSecureRePasswordProvider =
    StateNotifierProvider((ref) => IsSecureRePasswordNotifier());

class IsSecureRePasswordNotifier extends StateNotifier<bool> {
  IsSecureRePasswordNotifier() : super(true);

  set changed(bool value) => state = value;
}

final editingPersonalInformation =
    StateNotifierProvider((ref) => EditingPersonalInformation());

class EditingPersonalInformation extends StateNotifier<bool> {
  EditingPersonalInformation() : super(false);

  set changed(bool value) => state = value;
}

final genderAddAccountProvider =
    StateNotifierProvider<GenderAddAccountNotifier, String>(
  (ref) => GenderAddAccountNotifier(),
);

class GenderAddAccountNotifier extends StateNotifier<String> {
  GenderAddAccountNotifier() : super('');

  void update(String value) {
    state = value;
  }
}

final roleAddAccountProvider =
    StateNotifierProvider<RoleAddAccountNotifier, String>(
  (ref) => RoleAddAccountNotifier(),
);

class RoleAddAccountNotifier extends StateNotifier<String> {
  RoleAddAccountNotifier() : super('');

  void update(String value) {
    state = value;
  }
}

final roleModelAddAccountProvider = StateNotifierProvider<RoleAddAccount, Role>(
  (ref) => RoleAddAccount(),
);

class RoleAddAccount extends StateNotifier<Role> {
  RoleAddAccount() : super(const Role()) {
    fetchUser(Role());
  }

  Future<void> fetchUser(Role role) async {
    state = role;
  }
}

final genderEditProfileProvider =
    StateNotifierProvider<GenderEditProfileNotifier, String>(
  (ref) => GenderEditProfileNotifier(),
);

class GenderEditProfileNotifier extends StateNotifier<String> {
  GenderEditProfileNotifier() : super('');

  void update(String value) {
    state = value;
  }
}
