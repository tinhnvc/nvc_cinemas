import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

final authProvider = Provider<AuthProvider>(
  (ref) => AuthProvider(ref.read),
);

class AuthProvider {
  AuthProvider(this._reader);

  final Reader _reader;
  // late final ApiProvider _apiProvider = _reader(apiProvider);
  final loginForm = FormGroup({
    'email': FormControl<String>(),
    'password': FormControl<String>(),
  });
  final forgotPasswordForm = FormGroup({
    'email': FormControl<String>(),
  });
  final signUpForm = FormGroup({
    'accountName': FormControl<String>(),
    'email': FormControl<String>(),
    'password': FormControl<String>(),
    'name': FormControl<String>(),
    'phone': FormControl<String>(),
  });

  final buttonController = RoundedLoadingButtonController();

  // Future<void> login(BuildContext context, WidgetRef ref) async {
  //   buttonController.start();
  //   final loginResponse = await _apiProvider.request(
  //     'auth/login',
  //     'post',
  //     loginForm.value,
  //   );
  //
  //   await loginResponse.when(
  //     success: (success) async {
  //       ref
  //         ..refresh(profileProvider)
  //         ..watch(profileProvider);
  //       final tokenRepository = _reader(tokenRepositoryProvider);
  //       final token = success;
  //       await tokenRepository
  //           .saveToken(token['token'] as String)
  //           // .then((value) => InitUtil.initApp(ref))
  //           .then(
  //             (value) => Navigator.pushNamedAndRemoveUntil(
  //               context,
  //               '/home-page',
  //               (Route<dynamic> route) => false,
  //             ),
  //           );
  //     },
  //     error: (error) {
  //       displayFormErrors(error, loginForm);
  //       buttonController.reset();
  //     },
  //   );
  //
  //   buttonController.reset();
  // }
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
  // void resetPasswordSuccessPopup() {
  //   final ctx = OneContext().context;
  //   if (ctx != null) {
  //     Alert(
  //       context: ctx,
  //       type: AlertType.success,
  //       title: ctx.l10n.success,
  //       desc: ctx.l10n.passwordRecoverySuccess,
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
