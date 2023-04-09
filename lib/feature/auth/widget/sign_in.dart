import 'package:nvc_cinemas/feature/auth/model/user.dart';
import 'package:nvc_cinemas/feature/auth/provider/auth_provider.dart';
import 'package:nvc_cinemas/feature/auth/provider/roles_provider.dart';
import 'package:nvc_cinemas/feature/auth/provider/users_provider.dart';
import 'package:nvc_cinemas/gen/assets.gen.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:nvc_cinemas/l10n/l10n.dart';
import 'package:nvc_cinemas/shared/link/users.dart';
import 'package:nvc_cinemas/shared/provider/util_provider.dart';
import 'package:nvc_cinemas/shared/repository/language_repository.dart';
import 'package:nvc_cinemas/shared/util/init_util.dart';
import 'package:nvc_cinemas/shared/widget/form_text_field.dart';
import 'package:nvc_cinemas/shared/widget/snack_bar_support.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:uuid/uuid.dart';

class SignIn extends ConsumerWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    final inset = MediaQuery.of(context).viewInsets;
    final height = size.height - (padding.top + padding.bottom + inset.bottom);
    final width = size.width - (padding.left + padding.right + inset.right);
    final ratio = height / size.width;
    var timeBackPress = DateTime.now();
    final isVisibility = ref.watch(isVisibilityPassword)! as bool;
    final language = ref.watch(languageProvider);
    final users = ref.watch(usersProvider);
    ref.watch(rolesProvider);
    print(users.map((e) => e.email));

    return WillPopScope(
      onWillPop: () async {
        final difference = DateTime.now().difference(timeBackPress);
        final isExitWarning = difference >= const Duration(seconds: 2);
        timeBackPress = DateTime.now();

        if (isExitWarning) {
          final messageExitWarning = context.l10n.pressBackAgainToExit;
          SnackBarSupport.createAndDisplay(
            context: context,
            content: messageExitWarning,
            timeSecond: 2,
            hideAction: false,
          );

          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFEFE0E0),
        body: Container(
          margin: EdgeInsets.zero,
          // decoration: BoxDecoration(
          //   image: ratio >= 1.95
          //       ? const DecorationImage(
          //           image: Svg('assets/images/login-banner.svg'),
          //           fit: BoxFit.fitWidth,
          //           alignment: Alignment.topCenter,
          //         )
          //       : null,
          // ),
          child: Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // if (ratio < 1.95 && height > 450)
                Assets.images.logoPng.image(width: 250, fit: BoxFit.cover),
                if (ratio < 1.95) const SizedBox(height: 10),

                Text(
                  context.l10n.sign_in,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF363E59),
                  ),
                ),
                SizedBox(height: ratio < 1.95 ? 10 : 30),
                ReactiveForm(
                  formGroup: ref.watch(authProvider).loginForm,
                  child: Column(
                    children: [
                      FormTextField(
                        formControlName: 'email',
                        labelText: context.l10n.your_email,
                        size: FormTextFieldSize.lg,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      FormTextField(
                        formControlName: 'password',
                        labelText: context.l10n.password,
                        size: FormTextFieldSize.lg,
                        textInputAction: TextInputAction.done,
                        obscureText: isVisibility,
                        suffixIcon: IconButton(
                          onPressed: () {
                            ref.read(isVisibilityPassword.notifier).changed =
                                !isVisibility;
                          },
                          icon: Icon(
                            isVisibility
                                ? Icons.visibility
                                : Icons.visibility_off,
                            size: 20,
                            color: const Color(0xFF4B5574),
                          ),
                        ),
                        onSubmitted: () {},
                      ),
                      SizedBox(height: ratio < 1.95 ? 10 : 20),
                      RoundedLoadingButton(
                        color: ColorName.primary,
                        borderRadius: 20,
                        height: 60,
                        width: size.width * 0.6,
                        animateOnTap: false,
                        controller: ref.watch(authProvider).buttonController,
                        onPressed: () {
                          ref.read(authProvider).login(context, ref);
                          // print(Uuid().v4());
                        },
                        child: Text(
                          context.l10n.signIn,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      SizedBox(height: ratio < 1.95 ? 10 : 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Assets.images.googleLogo
                              .image(width: 50, fit: BoxFit.cover),
                          Text(context.l10n.signInWithGoogle)
                        ],
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          primary: const Color(0xFF4B5574),
                        ),
                        onPressed: () {
                          ref
                              .read(authProvider)
                              .forgotPasswordForm
                              .control('email')
                              .value = '';
                          Navigator.pushNamed(context, '/forgot-password');
                        },
                        child: Text(context.l10n.forgotPassword),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            style: TextButton.styleFrom(
                              primary: language == 'vi'
                                  ? ColorName.primary
                                  : const Color(0xFF4B5574),
                            ),
                            onPressed: () async {
                              await ref
                                  .read(languageRepositoryProvider)
                                  .saveLanguage('vi');
                              ref.read(languageProvider.notifier).update('vi');
                            },
                            child: Text(
                              context.l10n.vi,
                              style: TextStyle(
                                fontWeight:
                                    language == 'vi' ? FontWeight.w600 : null,
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(5),
                            child: Icon(
                              Icons.language_rounded,
                              size: 16,
                              color: ColorName.primary,
                            ),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              primary: language != 'vi'
                                  ? ColorName.primary
                                  : const Color(0xFF4B5574),
                            ),
                            onPressed: () async {
                              await ref
                                  .read(languageRepositoryProvider)
                                  .saveLanguage('en');
                              ref.read(languageProvider.notifier).update('en');
                            },
                            child: Text(
                              context.l10n.en,
                              style: TextStyle(
                                fontWeight:
                                    language != 'vi' ? FontWeight.w600 : null,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomSheet: Container(
          color: ColorName.pageBackground,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                context.l10n.newUser,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF4B5574),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  primary: const Color(0xFF2F80ED),
                ),
                onPressed: () {
                  InitUtil.initSignUpForm(ref);
                  Navigator.pushNamed(context, '/sign-up');

                  // Get.toNamed('/sign-up');
                },
                child: Text(context.l10n.signUpHere),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
