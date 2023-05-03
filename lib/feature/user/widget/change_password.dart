import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:nvc_cinemas/l10n/l10n.dart';
import 'package:nvc_cinemas/shared/provider/user_provider.dart';
import 'package:nvc_cinemas/shared/provider/util_provider.dart';
import 'package:nvc_cinemas/shared/widget/arrow_back_title.dart';
import 'package:nvc_cinemas/shared/widget/form_text_field.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class ChangePassword extends ConsumerWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    final inset = MediaQuery.of(context).viewInsets;
    final height = size.height - (padding.top + padding.bottom + inset.bottom);
    final width = size.width - (padding.left + padding.right + inset.right);
    final ratio = height / size.width;
    final isVietnamese = ref.watch(appLanguage)! as bool;

    final isSecureOldPassword = ref.watch(isSecureOldPasswordProvider)! as bool;
    final isSecureNewPassword = ref.watch(isSecureNewPasswordProvider)! as bool;
    final isSecureRePassword = ref.watch(isSecureRePasswordProvider)! as bool;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: ColorName.pageBackground,
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          children: [
            SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                height: height * 0.8,
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new ExactAssetImage(
                        'assets/images/change-password.png'),
                    fit: BoxFit.contain,
                  ),
                ),
                child: BackdropFilter(
                  filter: new ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                  child: Container(
                    decoration: new BoxDecoration(
                      color: ColorName.pageBackground.withOpacity(0.7),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        ArrowBackTitle(
                          title: context.l10n.changePassword,
                          textSize: 19,
                          onPressed: () => Navigator.pop(context),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ReactiveForm(
                          formGroup:
                              ref.read(userFormProvider).editPasswordForm,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FormTextField(
                                isEditProfileForm: true,
                                formControlName: 'oldPassword',
                                labelText: context.l10n.oldPassword,
                                obscureText: isSecureOldPassword,
                                maxLine: 1,
                                suffixIcon: IconButton(
                                  onPressed: () => ref
                                      .read(
                                          isSecureOldPasswordProvider.notifier)
                                      .changed = !isSecureOldPassword,
                                  icon: Icon(
                                    isSecureOldPassword
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    size: 19,
                                    color: ColorName.textNormal,
                                  ),
                                ),
                              ),
                              Divider(
                                color: ColorName.textNormal.withOpacity(0.5),
                                thickness: 1,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              FormTextField(
                                isEditProfileForm: true,
                                formControlName: 'password',
                                labelText: context.l10n.newPassword,
                                obscureText: isSecureNewPassword,
                                maxLine: 1,
                                suffixIcon: IconButton(
                                  onPressed: () => ref
                                      .read(
                                          isSecureNewPasswordProvider.notifier)
                                      .changed = !isSecureNewPassword,
                                  icon: Icon(
                                    isSecureNewPassword
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    size: 19,
                                    color: ColorName.textNormal,
                                  ),
                                ),
                              ),
                              Divider(
                                color: ColorName.textNormal.withOpacity(0.5),
                                thickness: 1,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              FormTextField(
                                isEditProfileForm: true,
                                formControlName: 'rePassword',
                                labelText: context.l10n.confirmPassword,
                                obscureText: isSecureRePassword,
                                maxLine: 1,
                                suffixIcon: IconButton(
                                  onPressed: () => ref
                                      .read(isSecureRePasswordProvider.notifier)
                                      .changed = !isSecureRePassword,
                                  icon: Icon(
                                    isSecureRePassword
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    size: 19,
                                    color: ColorName.textNormal,
                                  ),
                                ),
                              ),
                              Divider(
                                color: ColorName.textNormal.withOpacity(0.5),
                                thickness: 1,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text(
                                      context.l10n.cancel,
                                      style: const TextStyle(
                                        color: Color(0xFF363E59),
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  RoundedLoadingButton(
                                    color: ColorName.primary,
                                    borderRadius: 5,
                                    height: 40,
                                    width: 110,
                                    animateOnTap: false,
                                    controller: ref
                                        .watch(userFormProvider)
                                        .buttonController,
                                    onPressed: () {
                                      ref.read(userFormProvider).changePassword(
                                          ref,
                                          context,
                                          ref.watch(userProvider));
                                    },
                                    child: Text(
                                      context.l10n.save,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget rowInformation({
    required String title,
    required String content,
    required double width,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: width * 0.3,
            child: Text(
              title,
              style: TextStyle(
                overflow: TextOverflow.clip,
                fontSize: 15,
                color: ColorName.textNormal,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            width: width * 0.6,
            child: Text(
              content,
              style: TextStyle(
                overflow: TextOverflow.clip,
                fontSize: 15,
                color: ColorName.textNormal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget rowButton({
    required String content,
    required VoidCallback onPressed,
    bool? isVersion = false,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.3),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              content,
              style: TextStyle(
                color: ColorName.btnText,
                fontSize: 16,
              ),
            ),
            Container(
              child: Row(
                children: [
                  if (isVersion ?? false)
                    Text(
                      '1.0.0',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                      ),
                    ),
                  const SizedBox(
                    width: 10,
                  ),
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.grey[300],
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 17,
                      color: ColorName.textNormal,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
