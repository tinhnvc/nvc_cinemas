import 'package:nvc_cinemas/feature/auth/model/user.dart';
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

final userFormProvider = Provider<ProfileFormProvider>(
  (ref) => ProfileFormProvider(),
);

class ProfileFormProvider {
  ProfileFormProvider();

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
