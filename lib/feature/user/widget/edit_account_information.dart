import 'package:nvc_cinemas/feature/auth/provider/auth_provider.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:nvc_cinemas/l10n/l10n.dart';
import 'package:nvc_cinemas/shared/util/function_ulti.dart';
import 'package:nvc_cinemas/shared/widget/dropdown_widget.dart';
import 'package:nvc_cinemas/shared/widget/form_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/shared/provider/user_provider.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class EditAccountInformationModalSheet extends ConsumerWidget {
  const EditAccountInformationModalSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    final inset = MediaQuery.of(context).viewInsets;
    final height = size.height - (padding.top + padding.bottom + inset.bottom);
    final width = size.width - (padding.left + padding.right + inset.right);
    final ratio = height / size.width;

    final genderList = [
      context.l10n.unknown,
      context.l10n.male,
      context.l10n.female,
    ];
    final genderValue = ref.watch(genderEditProfileProvider);
    final formGroup = ref.read(userFormProvider).editProfileForm;

    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Stack(
            children: [
              Container(
                height: 60,
                padding: const EdgeInsets.only(
                  left: 25,
                  // top: 10,
                  // bottom: 10,
                  right: 5,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${context.l10n.edit} '
                      '${context.l10n.accountInfo.toLowerCase()}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Color(0xFF363E59),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 60),
                child: const Divider(
                  height: 3,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 60),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        child: ReactiveForm(
                          formGroup: ref.read(userFormProvider).editProfileForm,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FormTextField(
                                formControlName: 'fullName',
                                labelText: context.l10n.fullName,
                                maxLine: 1,
                                isEditProfileForm: true,
                                textInputAction: TextInputAction.next,
                                suffixIcon: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.perm_contact_cal_rounded,
                                    size: 19,
                                    color: Color(0xFF8698B7),
                                  ),
                                ),
                              ),
                              const Divider(
                                color: Color(0xFFE3E8F9),
                                thickness: 1.5,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              FormTextField(
                                isEditProfileForm: true,
                                formControlName: 'phoneNumber',
                                labelText: context.l10n.phoneNumber,
                                maxLine: 1,
                                textInputType: TextInputType.phone,
                                textInputAction: TextInputAction.next,
                                suffixIcon: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.phone,
                                    size: 19,
                                    color: Color(0xFF8698B7),
                                  ),
                                ),
                              ),
                              const Divider(
                                color: Color(0xFFE3E8F9),
                                thickness: 1.5,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              FormTextField(
                                isEditProfileForm: true,
                                formControlName: 'yob',
                                labelText: context.l10n.yearOfBirth,
                                textInputType: TextInputType.number,
                                maxLine: 1,
                                textInputAction: TextInputAction.next,
                                suffixIcon: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.date_range_sharp,
                                    size: 19,
                                    color: Color(0xFF8698B7),
                                  ),
                                ),
                              ),
                              const Divider(
                                color: Color(0xFFE3E8F9),
                                thickness: 1.5,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  context.l10n.gender,
                                  style: const TextStyle(
                                    color: Color(0xFF363E59),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  bottom: 10,
                                  left: 10,
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
                                        .read(
                                            genderEditProfileProvider.notifier)
                                        .update(value);
                                    ref
                                        .read(userFormProvider)
                                        .editProfileForm
                                        .control('gender')
                                        .value = gender;
                                  },
                                ),
                              ),
                              const Divider(
                                color: Color(0xFFE3E8F9),
                                thickness: 1.5,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          right: 25,
                          bottom: 20,
                        ),
                        child: Row(
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
                              controller:
                                  ref.watch(userFormProvider).buttonController,
                              onPressed: () {
                                final user = ref.watch(userProvider);
                                ref
                                    .read(userFormProvider)
                                    .editCustomerInfo(ref, context, user);
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
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
