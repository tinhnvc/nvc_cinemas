import 'package:nvc_cinemas/feature/auth/provider/auth_provider.dart';
import 'package:nvc_cinemas/gen/assets.gen.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:nvc_cinemas/l10n/l10n.dart';
import 'package:nvc_cinemas/shared/widget/arrow_back_title.dart';
import 'package:nvc_cinemas/shared/widget/form_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:uuid/uuid.dart';

class ForgotPassword extends ConsumerWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    final inset = MediaQuery.of(context).viewInsets;
    final height = size.height - (padding.top + padding.bottom + inset.bottom);
    final ratio = height / size.width;
    final formGroup = ref.watch(authProvider).forgotPasswordForm;

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          children: [
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  ArrowBackTitle(
                    title: context.l10n.forgot_password,
                    onPressed: () => Navigator.pop(context),
                  ),
                  SizedBox(height: ratio < 1.95 ? 10 : 40),
                  if (ratio < 1.95)
                    const SizedBox(height: 20)
                  else
                    const Icon(
                      Icons.question_mark_sharp,
                      size: 100,
                      color: ColorName.primary,
                    ),
                  SizedBox(height: ratio < 1.95 ? 10 : 40),
                  Text(
                    context.l10n.emailForgotPassword,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF4B5574),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: ratio < 1.95 ? 20 : 40),
                  ReactiveForm(
                    formGroup: ref.watch(authProvider).forgotPasswordForm,
                    child: Column(
                      children: [
                        FormTextField(
                          formControlName: 'email',
                          labelText: context.l10n.email_hint,
                          size: FormTextFieldSize.lg,
                        ),
                        const SizedBox(height: 10),
                        SizedBox(height: ratio < 1.95 ? 20 : 40),
                        RoundedLoadingButton(
                          color: ColorName.primary,
                          borderRadius: 36,
                          height: 60,
                          width: size.width,
                          animateOnTap: false,
                          controller: ref.watch(authProvider).buttonController,
                          onPressed: () async {
                            final email = formGroup.control('email').value;
                            final message = Uuid().v4().split('-').toList();
                            ref.read(authProvider).sendEmailResetPassword(
                                  ref: ref,
                                  email: email,
                                  message: message[0],
                                );
                          },
                          child: Text(
                            context.l10n.retrievingPassword,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        margin: const EdgeInsets.only(bottom: 10),
        color: const Color(0xFFFFFFFF),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
                ref.read(authProvider).signUpForm.reset();
                // InitUtil.initSignUpForm(ref);
                Navigator.pushNamed(context, '/sign-up');
              },
              child: Text(context.l10n.signUpHere),
            ),
          ],
        ),
      ),
    );
  }
}
