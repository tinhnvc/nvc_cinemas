import 'dart:ui';

import 'package:intl/intl.dart';
import 'package:nvc_cinemas/feature/auth/provider/auth_provider.dart';
import 'package:nvc_cinemas/feature/user/widget/edit_account_information.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:nvc_cinemas/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:nvc_cinemas/l10n/l10n.dart';
import 'package:nvc_cinemas/shared/provider/user_provider.dart';
import 'package:nvc_cinemas/shared/util/format_support.dart';
import 'package:nvc_cinemas/shared/widget/arrow_back_title.dart';
import 'package:nvc_cinemas/shared/widget/call_modal_sheet.dart';
import 'package:nvc_cinemas/shared/widget/rounded_button_widget.dart';

class AccountInformation extends ConsumerWidget {
  const AccountInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    final inset = MediaQuery.of(context).viewInsets;
    final height = size.height - (padding.top + padding.bottom + inset.bottom);
    final width = size.width - (padding.left + padding.right + inset.right);
    final ratio = height / size.width;

    final user = ref.watch(userProvider);

    return Scaffold(
      backgroundColor: ColorName.pageBackground,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: ListView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            children: [
              SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                      image: new ExactAssetImage(
                          'assets/images/account-infor.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                  child: BackdropFilter(
                    filter: new ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                    child: Container(
                      decoration: new BoxDecoration(
                        color: ColorName.pageBackground.withOpacity(0.7),
                      ),
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const SizedBox(height: 20),
                          ArrowBackTitle(
                            title: context.l10n.accountInfo,
                            textSize: 19,
                            onPressed: () => Navigator.pop(context),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 50,
                                  vertical: 10,
                                ),
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 45,
                                      backgroundColor: const Color(0xFFE6EEFC),
                                      child: Text(
                                        user.fullName != null
                                            ? '${ref.read(userProvider.notifier).getSortName()}'
                                            : 'C',
                                        style: const TextStyle(
                                          fontSize: 40,
                                          color: Color(0xFF4B5574),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 3,
                                      ),
                                      decoration: BoxDecoration(
                                        color: ColorName.primary,
                                        borderRadius: BorderRadius.horizontal(
                                          right: Radius.circular(15),
                                          left: Radius.circular(15),
                                        ),
                                      ),
                                      child: Text(
                                        user.role!.roleName == 'customer'
                                            ? context.l10n.customer
                                            : user.role!.roleName == 'admin'
                                                ? context.l10n.admin
                                                : context.l10n.manager,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      user.fullName ?? context.l10n.customer,
                                      style: const TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF363E59),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 10),
                            child: const Divider(
                              color: ColorName.textNormal,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              RoundedButtonWidget(
                                content: context.l10n.edit,
                                onPressed: () {
                                  CallModalSheet.editAccountInformation(
                                      context);
                                },
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          rowInformation(
                            title: 'Email',
                            content: user.email ?? '',
                            width: width,
                          ),
                          rowInformation(
                            title: context.l10n.phoneNumber,
                            content: user.phoneNumber ?? '',
                            width: width,
                          ),
                          rowInformation(
                            title: context.l10n.gender,
                            content: user.gender == 'male'
                                ? context.l10n.male
                                : context.l10n.female,
                            width: width,
                          ),
                          rowInformation(
                            title: context.l10n.yearOfBirth,
                            content: user.yob ?? '',
                            width: width,
                          ),
                          rowInformation(
                            title: context.l10n.createTime,
                            content: FormatSupport.toDateTimeNonHour(
                                user.updateAt ?? 1676169202034),
                            width: width,
                          ),
                          rowInformation(
                            title: context.l10n.updateAt,
                            content: FormatSupport.toDateTime(
                                user.updateAt ?? 1676169202034),
                            width: width,
                          ),
                          rowButton(
                            title: context.l10n.changePassword,
                            icon: Icons.arrow_forward_ios_outlined,
                            onPressed: () {
                              Navigator.pushNamed(context, '/change-password');
                            },
                          ),
                          rowButton(
                            title: context.l10n.logout,
                            icon: Icons.logout,
                            isSpecial: true,
                            onPressed: () {
                              ref.read(authProvider).logout();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget rowInformation({
    required String title,
    required String content,
    required double width,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.3)),
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
            width: width * 0.5,
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
    required String title,
    required IconData icon,
    required VoidCallback onPressed,
    bool? isSpecial,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(color: Colors.white.withOpacity(0.3)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                overflow: TextOverflow.clip,
                fontSize: 15,
                color: isSpecial ?? false ? Colors.red : ColorName.textNormal,
                fontWeight: FontWeight.w600,
              ),
            ),
            Icon(
              icon,
              size: 20,
              color: isSpecial ?? false ? Colors.red : ColorName.textNormal,
            )
          ],
        ),
      ),
    );
  }
}
