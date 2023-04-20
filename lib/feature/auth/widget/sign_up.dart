import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:nvc_cinemas/feature/auth/provider/auth_provider.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:nvc_cinemas/l10n/l10n.dart';
import 'package:nvc_cinemas/shared/util/function_ulti.dart';
import 'package:nvc_cinemas/shared/widget/arrow_back_title.dart';
import 'package:nvc_cinemas/shared/widget/check_box_widget.dart';
import 'package:nvc_cinemas/shared/widget/dropdown_widget.dart';
import 'package:nvc_cinemas/shared/widget/form_text_field.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class SignUp extends ConsumerWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    final inset = MediaQuery.of(context).viewInsets;
    final height = size.height - (padding.top + padding.bottom + inset.bottom);
    final width = size.width - (padding.left + padding.right + inset.right);
    final ratio = height / size.width;

    final isAccept = ref.watch(isAcceptTerms)! as bool;
    final genderList = [
      context.l10n.unknown,
      context.l10n.male,
      context.l10n.female,
    ];
    final genderValue = ref.watch(genderSignUpProvider);
    final isVisibility = ref.watch(isVisibilitySignUpPassword)! as bool;

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
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    ArrowBackTitle(
                      title: context.l10n.signUp,
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ReactiveForm(
                      formGroup: ref.read(authProvider).signUpForm,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FormTextField(
                            formControlName: 'email',
                            labelText: context.l10n.your_email,
                            size: FormTextFieldSize.lg,
                            suffixIcon: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.email,
                                size: 19,
                                color: Color(0xFF8698B7),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          FormTextField(
                            formControlName: 'password',
                            labelText: context.l10n.password,
                            size: FormTextFieldSize.lg,
                            obscureText: isVisibility,
                            suffixIcon: IconButton(
                              onPressed: () {
                                ref
                                    .read(isVisibilitySignUpPassword.notifier)
                                    .changed = !isVisibility;
                              },
                              icon: Icon(
                                isVisibility
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                size: 20,
                                color: Color(0xFF8698B6),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          FormTextField(
                            formControlName: 'fullName',
                            labelText: context.l10n.fullName,
                            size: FormTextFieldSize.lg,
                            suffixIcon: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.note_alt_rounded,
                                size: 19,
                                color: Color(0xFF8698B7),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          FormTextField(
                            formControlName: 'phoneNumber',
                            labelText: context.l10n.phoneNumber,
                            size: FormTextFieldSize.lg,
                            textInputType: TextInputType.phone,
                            suffixIcon: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.phone,
                                size: 19,
                                color: Color(0xFF8698B7),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          FormTextField(
                            formControlName: 'yob',
                            labelText: context.l10n.yearOfBirth,
                            size: FormTextFieldSize.lg,
                            textInputType: TextInputType.number,
                            suffixIcon: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.date_range,
                                size: 19,
                                color: Color(0xFF8698B7),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            context.l10n.gender,
                            style: const TextStyle(
                              color: Color(0xFF363E59),
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              bottom: 10,
                              left: 5,
                              right: width * 0.3,
                            ),
                            child: DropdownWidget(
                              value: genderValue.isNotEmpty
                                  ? genderValue
                                  : context.l10n.unknown,
                              values: genderList,
                              onChanged: (String value) {
                                final gender =
                                    FunctionUtil.genderSelectToFormValue(
                                  context,
                                  value,
                                );
                                ref
                                    .read(genderSignUpProvider.notifier)
                                    .update(value);
                                ref
                                    .read(authProvider)
                                    .signUpForm
                                    .control('gender')
                                    .value = gender;
                              },
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CheckBoxWidget(
                                isChecked: isAccept,
                                onPressed: () => ref
                                    .read(isAcceptTerms.notifier)
                                    .changed = !isAccept,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => ref
                                      .read(isAcceptTerms.notifier)
                                      .changed = !isAccept,
                                  child: Row(
                                    children: [
                                      Text(
                                        '${context.l10n.acceptWith} ',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF697392),
                                          overflow: TextOverflow.clip,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () => Navigator.pushNamed(
                                            context, '/term-of-use'),
                                        child: Text(
                                          context.l10n.termsAndConditions,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.blue,
                                            overflow: TextOverflow.clip,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const SizedBox(height: 20),
                              SizedBox(
                                width: double.infinity,
                                child: RoundedLoadingButton(
                                  color: ColorName.primary,
                                  borderRadius: 36,
                                  height: 60,
                                  width: size.width,
                                  animateOnTap: false,
                                  disabledColor: ColorName.primary,
                                  controller:
                                      ref.watch(authProvider).buttonController,
                                  onPressed: isAccept
                                      ? () async {
                                          print(ref
                                              .read(authProvider)
                                              .signUpForm
                                              .value);
                                          await ref.read(authProvider).signUp(
                                                context,
                                                ref,
                                              );
                                        }
                                      : null,
                                  child: Text(
                                    context.l10n.signUp,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 60),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        color: ColorName.pageBackground,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              context.l10n.alreadyAccount,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF4B5574),
              ),
            ),
            SizedBox(
              // width: double.infinity,
              child: TextButton(
                style: TextButton.styleFrom(
                  primary: const Color(0xFF2F80ED),
                ),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/sign-in', (Route<dynamic> route) => false);
                },
                child: Text(context.l10n.signInHere),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
