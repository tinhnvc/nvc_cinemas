import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/feature/auth/model/user.dart';
import 'package:nvc_cinemas/feature/auth/provider/roles_provider.dart';
import 'package:nvc_cinemas/feature/auth/provider/users_provider.dart';
import 'package:nvc_cinemas/feature/movie/provider/day_of_week_provider.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:nvc_cinemas/l10n/l10n.dart';
import 'package:nvc_cinemas/shared/enum/navigation_item.dart';
import 'package:nvc_cinemas/shared/link/email_sender.dart';
import 'package:nvc_cinemas/shared/provider/navigation_provider.dart';
import 'package:nvc_cinemas/shared/provider/user_provider.dart';
import 'package:nvc_cinemas/shared/widget/snack_bar_support.dart';
import 'package:one_context/one_context.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

final authProvider = Provider<AuthProvider>(
  (ref) => AuthProvider(ref.read),
);

class AuthProvider {
  AuthProvider(this._reader);

  final Reader _reader;

  final loginForm = FormGroup({
    'email': FormControl<String>(),
    'password': FormControl<String>(),
  });
  final forgotPasswordForm = FormGroup({
    'email': FormControl<String>(),
  });
  final signUpForm = FormGroup({
    'email': FormControl<String>(),
    'password': FormControl<String>(),
    'phoneNumber': FormControl<String>(),
    'fullName': FormControl<String>(),
    'gender': FormControl<String>(),
    'yob': FormControl<String>(),
  });

  final buttonController = RoundedLoadingButtonController();

  Future<void> login(BuildContext context, WidgetRef ref) async {
    buttonController.start();
    await Future.delayed(const Duration(milliseconds: 700));
    final email = loginForm.control('email').value;
    final password = loginForm.control('password').value;

    final users = ref.watch(usersProvider);
    if (!checkEmptyLoginForm()) {
      buttonController.reset();
      return;
    }

    var response = false;
    if (users.isNotEmpty) {
      for (final item in users) {
        if (item.email == email && item.password == password) {
          if (!item.active!) {
            SnackBarSupport.accountBaned(context: context);
            buttonController.reset();
            return;
          }

          ref.read(userProvider.notifier).fetchUser(item);
          if (item.role!.roleName == 'admin' ||
              item.role!.roleName == 'manager') {
            ref
                .read(navigationProvider.notifier)
                .setNavigationItem(NavigationItem.mCategory);
          } else {
            ref
                .read(navigationProvider.notifier)
                .setNavigationItem(NavigationItem.home);
          }
          response = true;
        }
      }
    }
    ref.read(dayOfWeekProvider.notifier).fetchDayOfWeek(ref, context);
    if (response) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/home-page',
        (Route<dynamic> route) => false,
      );
    } else {
      SnackBarSupport.loginFailed(context: context);
    }

    buttonController.reset();
  }

  Future<void> signUp(BuildContext context, WidgetRef ref) async {
    buttonController.start();
    await Future.delayed(const Duration(milliseconds: 700));
    final email = signUpForm.control('email').value;
    final password = signUpForm.control('password').value;
    final fullName = signUpForm.control('fullName').value;
    final phoneNumber = signUpForm.control('phoneNumber').value;
    final gender = signUpForm.control('gender').value;
    final yob = signUpForm.control('yob').value;

    final users = ref.watch(usersProvider);
    if (!checkEmptySignUpForm(ref)) {
      buttonController.reset();
      return;
    }

    var response = false;
    final newUser = User(
      userId: Uuid().v4(),
      email: email,
      role: ref.watch(rolesProvider)[2],
      password: password,
      fullName: fullName,
      phoneNumber: phoneNumber,
      gender: gender,
      yob: yob,
      active: true,
      createAt: DateTime.now().millisecondsSinceEpoch,
      updateAt: DateTime.now().millisecondsSinceEpoch,
    );
    ref.read(usersProvider.notifier).add(newUser);
    response = true;

    if (response) {
      buttonController.reset();
      await OneContext().pushNamed('/sign-up-successful');
    }

    buttonController.reset();
  }

  bool checkEmptyLoginForm() {
    final email = loginForm.control('email').value.toString();
    final password = loginForm.control('password').value.toString();
    if (email == 'null' || email.isEmpty) {
      loginForm.control('email').setErrors({'Email không được bỏ trống': true});
    }
    if (password == 'null' || password.isEmpty) {
      loginForm
          .control('password')
          .setErrors({'Mật khẩu không được bỏ trống': true});
    }

    return email != 'null' &&
        email.isNotEmpty &&
        password != 'null' &&
        password.isNotEmpty;
  }

  bool checkEmptyForgotPasswordForm(WidgetRef ref) {
    final users = ref.watch(usersProvider);
    final email = forgotPasswordForm.control('email').value.toString();
    if (email == 'null' || email.isEmpty) {
      forgotPasswordForm
          .control('email')
          .setErrors({'Email không được bỏ trống': true});
    }
    final emails = users.map((e) => e.email).toList();
    if (!emails.contains(email)) {
      forgotPasswordForm
          .control('email')
          .setErrors({'Email $email không tồn tại': true});
    }
    return email != 'null' && email.isNotEmpty && emails.contains(email);
  }

  bool checkEmptySignUpForm(WidgetRef ref) {
    final users = ref.watch(usersProvider);
    final email = signUpForm.control('email').value.toString();
    final password = signUpForm.control('password').value.toString();
    final fullName = signUpForm.control('fullName').value.toString();
    final phoneNumber = signUpForm.control('phoneNumber').value.toString();
    final gender = signUpForm.control('gender').value.toString();
    final yob = signUpForm.control('yob').value.toString();
    if (email == 'null' || email.isEmpty) {
      signUpForm
          .control('email')
          .setErrors({'Email không được bỏ trống': true});
    }
    final emails = users.map((e) => e.email).toList();
    if (emails.contains(email)) {
      signUpForm
          .control('email')
          .setErrors({'Email $email đã được sử dụng để đăng ký': true});
    }
    if (password == 'null' || password.isEmpty) {
      signUpForm
          .control('password')
          .setErrors({'Mật khẩu không được bỏ trống': true});
    }
    if (fullName == 'null' || fullName.isEmpty) {
      signUpForm
          .control('fullName')
          .setErrors({'Họ tên không được bỏ trống': true});
    }
    if (phoneNumber == 'null' || phoneNumber.isEmpty) {
      signUpForm
          .control('phoneNumber')
          .setErrors({'Số điện thoại không được bỏ trống': true});
    }
    if (yob == 'null' || yob.isEmpty) {
      signUpForm
          .control('yob')
          .setErrors({'Năm sinh không được bỏ trống': true});
    }

    return email != 'null' &&
        email.isNotEmpty &&
        password != 'null' &&
        password.isNotEmpty &&
        fullName != 'null' &&
        fullName.isNotEmpty &&
        phoneNumber != 'null' &&
        phoneNumber.isNotEmpty &&
        gender != 'null' &&
        gender.isNotEmpty &&
        yob != 'null' &&
        yob.isNotEmpty &&
        !emails.contains(email);
  }

  Future<void> sendEmailResetPassword({
    required WidgetRef ref,
    required String email,
    required String message,
  }) async {
    buttonController.start();
    await Future.delayed(const Duration(milliseconds: 700));
    if (!checkEmptyForgotPasswordForm(ref)) {
      buttonController.reset();
      return;
    }

    final users = ref.watch(usersProvider);
    final user = users.firstWhere((element) => element.email == email);
    resetPasswordSuccessPopup();
    buttonController.reset();
    print('New pass: $message');
    ref.read(usersProvider.notifier).changePassword(user.userId!, message);

    print(user);

    final url = Uri.parse(urlSendEmail);
    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'service_id': serviceId,
          'template_id': templateId,
          'user_id': userId,
          'accessToken': privateKey,
          'template_params': {
            'to_email': user.email,
            'to_name': user.fullName,
            'message': message,
          }
        }));
    print('Send request: ${response.body}');
  }

  Future<void> logout() async {
    await OneContext()
        .pushNamedAndRemoveUntil('/sign-in', (Route<dynamic> route) => false);
  }

  void resetPasswordSuccessPopup() {
    final ctx = OneContext().context;
    if (ctx != null) {
      Alert(
        context: ctx,
        type: AlertType.success,
        title: ctx.l10n.success,
        desc: ctx.l10n.passwordRecoverySuccess,
        style: const AlertStyle(
          titleStyle: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
          descStyle: TextStyle(
            fontSize: 15,
          ),
        ),
        buttons: [
          DialogButton(
            color: ColorName.primary,
            radius: const BorderRadius.all(Radius.circular(5)),
            height: 44,
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              ctx.l10n.ok,
              style: const TextStyle(
                color: ColorName.btnText,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ).show();
    }
  }

//
// Future<void> signUp(WidgetRef ref) async {
//   buttonController.start();
//   final registerCheckResponse = await _apiProvider.request(
//     'auth/register',
//     'post',
//     signUpForm.value,
//   );
//
//   await registerCheckResponse.when(
//     success: (success) async {
//       buttonController.reset();
//       await OneContext().pushNamed('/sign-up-successful');
//     },
//     error: (error) async {
//       displayFormErrors(error, signUpForm);
//       buttonController.reset();
//     },
//   );
//   buttonController.reset();
// }
//
// Future<void> forgotPassword() async {
//   buttonController.start();
//   final response = await _apiProvider.request(
//     'auth/forgot',
//     'post',
//     forgotPasswordForm.value,
//   );
//   final context = OneContext().context;
//
//   buttonController.reset();
//   await response.when(
//     success: (success) async {
//       success as bool
//           ? resetPasswordSuccessPopup()
//           : resetPasswordFailedPopup();
//     },
//     error: (error) {
//       displayFormErrors(error, forgotPasswordForm);
//       buttonController.reset();
//     },
//   );
//   buttonController.reset();
// }
//
// Future<void> logout() async {
//   final tokenRepository = _reader(tokenRepositoryProvider);
//   final response =
//       await _reader(tokenRepositoryProvider).fetchToken().then((token) {
//     _apiProvider.request(
//       'auth/logout',
//       'post',
//       {
//         'token': '$token',
//       },
//     );
//   });
//   await tokenRepository.remove();
//   await ProfileRepository().remove();
//   await OneContext()
//       .pushNamedAndRemoveUntil('/sign-in', (Route<dynamic> route) => false);
// }
//

//
// void resetPasswordFailedPopup() {
//   final ctx = OneContext().context;
//   if (ctx != null) {
//     Alert(
//       context: ctx,
//       type: AlertType.warning,
//       title: ctx.l10n.warning,
//       desc: ctx.l10n.passwordRecoveryAlreadySent,
//       style: const AlertStyle(
//         titleStyle: TextStyle(
//           fontSize: 17,
//           fontWeight: FontWeight.bold,
//         ),
//         descStyle: TextStyle(
//           fontSize: 15,
//         ),
//       ),
//       buttons: [
//         DialogButton(
//           color: ColorName.primary,
//           radius: const BorderRadius.all(Radius.circular(5)),
//           height: 44,
//           onPressed: () => Navigator.pop(ctx),
//           child: Text(
//             ctx.l10n.ok,
//             style: const TextStyle(
//               color: ColorName.btnText,
//               fontWeight: FontWeight.bold,
//               fontSize: 14,
//             ),
//           ),
//         ),
//       ],
//     ).show();
//   }
// }
}

final isAcceptTerms = StateNotifierProvider((ref) => IsAcceptTerms());

class IsAcceptTerms extends StateNotifier<bool> {
  IsAcceptTerms() : super(false);

  set changed(bool value) => state = value;
}

final isVisibilityPassword =
    StateNotifierProvider((ref) => IsVisibilityPassword());

class IsVisibilityPassword extends StateNotifier<bool> {
  IsVisibilityPassword() : super(true);

  set changed(bool value) => state = value;
}

final isVisibilitySignUpPassword =
    StateNotifierProvider((ref) => IsVisibilitySignUpPassword());

class IsVisibilitySignUpPassword extends StateNotifier<bool> {
  IsVisibilitySignUpPassword() : super(true);

  set changed(bool value) => state = value;
}

final genderSignUpProvider =
    StateNotifierProvider<GenderSignUpNotifier, String>(
  (ref) => GenderSignUpNotifier(),
);

class GenderSignUpNotifier extends StateNotifier<String> {
  GenderSignUpNotifier() : super('');

  void update(String value) {
    state = value;
  }
}
