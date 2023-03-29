import 'package:nvc_cinemas/feature/auth/provider/auth_provider.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:nvc_cinemas/l10n/l10n.dart';
import 'package:nvc_cinemas/shared/provider/util_provider.dart';
import 'package:nvc_cinemas/shared/repository/language_repository.dart';
import 'package:nvc_cinemas/shared/widget/form_text_field.dart';
import 'package:nvc_cinemas/shared/widget/snack_bar_support.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class SignIn extends ConsumerWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    final inset = MediaQuery.of(context).viewInsets;
    final height = size.height - (padding.top + padding.bottom + inset.bottom);
    final ratio = height / size.width;
    var timeBackPress = DateTime.now();
    final isVisibility = ref.watch(isVisibilityPassword)! as bool;
    final language = ref.watch(languageProvider);

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
        backgroundColor: const Color(0xFFFFFFFF),
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
              children: <Widget>[
                // if (ratio < 1.95 && height > 450)
                // Assets.images.logo.svg(width: 110, height: 75),
                if (ratio < 1.95) const SizedBox(height: 20),
                const SizedBox(
                  height: 30,
                ),
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
                        formControlName: 'password',
                        labelText: context.l10n.password_hint,
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
                      SizedBox(height: ratio < 1.95 ? 10 : 40),
                      RoundedLoadingButton(
                        color: ColorName.primary,
                        borderRadius: 36,
                        height: 60,
                        width: size.width,
                        animateOnTap: false,
                        controller: ref.watch(authProvider).buttonController,
                        onPressed: () async {},
                        child: Text(
                          context.l10n.sign_in,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      if (ratio > 1.95) const SizedBox(height: 20),
                      TextButton(
                        style: TextButton.styleFrom(
                          primary: const Color(0xFF4B5574),
                        ),
                        onPressed: () {},
                        child: Text(context.l10n.forgot_password),
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
      ),
    );
  }
}
