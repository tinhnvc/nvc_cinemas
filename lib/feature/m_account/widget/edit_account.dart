import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/feature/auth/model/user.dart';
import 'package:nvc_cinemas/feature/m_movie/provider/m_movie_provider.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:nvc_cinemas/l10n/l10n.dart';
import 'package:nvc_cinemas/shared/provider/user_provider.dart';
import 'package:nvc_cinemas/shared/util/function_ulti.dart';
import 'package:nvc_cinemas/shared/widget/arrow_back_title.dart';
import 'package:nvc_cinemas/shared/widget/dropdown_widget.dart';
import 'package:nvc_cinemas/shared/widget/form_text_field.dart';
import 'package:nvc_cinemas/shared/widget/time_create_and_update.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class EditAccount extends ConsumerWidget {
  const EditAccount({required this.account, Key? key}) : super(key: key);
  final User account;

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
    final genderValue = ref.watch(genderAddAccountProvider);
    final roleList = ['Khách hàng', 'Nhân viên'];
    final categoryValue = ref.watch(categoryAddMovieProvider);
    final roleValue = ref.watch(roleAddAccountProvider);

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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    ArrowBackTitle(
                      title:
                          '${context.l10n.edit} ${context.l10n.account.toLowerCase()}',
                      textSize: 19,
                      onPressed: () => Navigator.pop(context),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 15,
                      ),
                      child: ReactiveForm(
                        formGroup: ref.read(userFormProvider).addAccountForm,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Email',
                              style: const TextStyle(
                                color: Color(0xFF363E59),
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                account.email ?? context.l10n.notUpdated,
                                style: const TextStyle(
                                  color: Color(0xFF363E59),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Text(
                              context.l10n.password,
                              style: const TextStyle(
                                color: Color(0xFF363E59),
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                              child: FormTextField(
                                  isCrudForm: true,
                                  formControlName: 'password',
                                  maxLine: 1,
                                  obscureText: true,
                                  textInputAction: TextInputAction.next,
                                  labelText: '${context.l10n.input} '
                                      '${context.l10n.password}'),
                            ),
                            Text(
                              context.l10n.fullName,
                              style: const TextStyle(
                                color: Color(0xFF363E59),
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                              child: FormTextField(
                                  isCrudForm: true,
                                  formControlName: 'fullName',
                                  maxLine: 1,
                                  textInputAction: TextInputAction.next,
                                  labelText: '${context.l10n.input} '
                                      '${context.l10n.fullName}'),
                            ),
                            Text(
                              context.l10n.phoneNumber,
                              style: const TextStyle(
                                color: Color(0xFF363E59),
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                              child: FormTextField(
                                  isCrudForm: true,
                                  formControlName: 'phoneNumber',
                                  maxLine: 1,
                                  textInputType: TextInputType.phone,
                                  textInputAction: TextInputAction.next,
                                  labelText: '${context.l10n.input} '
                                      '${context.l10n.fullName}'),
                            ),
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
                                      .read(genderAddAccountProvider.notifier)
                                      .update(value);
                                  ref
                                      .read(userFormProvider)
                                      .addAccountForm
                                      .control('gender')
                                      .value = gender;
                                },
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  context.l10n.role,
                                  style: const TextStyle(
                                    color: Color(0xFF363E59),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 4,
                                  ),
                                  margin: EdgeInsets.only(
                                    bottom: 10,
                                    top: 10,
                                    left: 20,
                                  ),
                                  decoration: BoxDecoration(
                                      color: FunctionUtil.roleTitleToColor(
                                          account.role!.title!),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Text(
                                    account.role!.title!,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              context.l10n.yearOfBirth,
                              style: const TextStyle(
                                color: Color(0xFF363E59),
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                              child: FormTextField(
                                  isCrudForm: true,
                                  formControlName: 'yob',
                                  maxLine: 1,
                                  textInputType: TextInputType.number,
                                  textInputAction: TextInputAction.done,
                                  labelText: '${context.l10n.input} '
                                      '${context.l10n.yearOfBirth}'),
                            ),
                            TimeCrateAndUpdate(
                              createTime: account.createAt!,
                              updateTime: account.updateAt!,
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text(
                                      context.l10n.back,
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
                                      ref
                                          .read(userFormProvider)
                                          .editAccount(ref, context, account);
                                    },
                                    child: Text(
                                      context.l10n.update,
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
          ],
        ),
      ),
    );
  }
}
