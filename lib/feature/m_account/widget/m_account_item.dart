import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/feature/auth/model/user.dart';
import 'package:nvc_cinemas/feature/auth/provider/users_provider.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:nvc_cinemas/l10n/l10n.dart';
import 'package:nvc_cinemas/shared/util/format_support.dart';
import 'package:nvc_cinemas/shared/util/function_ulti.dart';
import 'package:nvc_cinemas/shared/util/init_util.dart';
import 'package:nvc_cinemas/shared/widget/snack_bar_support.dart';

class MAccountItem extends ConsumerWidget {
  const MAccountItem({required this.account, Key? key}) : super(key: key);
  final User account;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    final inset = MediaQuery.of(context).viewInsets;
    final height = size.height - (padding.top + padding.bottom + inset.bottom);
    final width = size.width - (padding.left + padding.right + inset.right);
    final ratio = height / size.width;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: ColorName.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: width * 0.4,
                      child: Text(
                        '${account.fullName}',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 17,
                          color: ColorName.textNormal,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: account.role!.roleName == 'admin'
                              ? () {
                                  SnackBarSupport.avoidFunction(
                                    context: context,
                                    hideAction: true,
                                  );
                                }
                              : () {
                                  InitUtil.initEditAccount(
                                      ref: ref,
                                      context: context,
                                      user: account);
                                  Navigator.pushNamed(context, '/edit-account',
                                      arguments: account);
                                },
                          child: Icon(
                            Icons.edit_note,
                            size: 25,
                            color: ColorName.primary,
                          ),
                        ),
                        Transform.scale(
                          scale: 0.7,
                          alignment: Alignment.topCenter,
                          child: CupertinoSwitch(
                            value: account.active ?? false,
                            onChanged: account.role!.roleName == 'admin'
                                ? (bool value) {
                                    SnackBarSupport.avoidFunction(
                                      context: context,
                                      hideAction: true,
                                    );
                                  }
                                : (bool value) {
                                    if (!value) {
                                      FunctionUtil.alertPopUpConfirmWithContent(
                                          onPressedConfirm: () {
                                            ref
                                                .read(usersProvider.notifier)
                                                .switchActive(
                                                    account.userId!, value);
                                          },
                                          content:
                                              'Tài khoản\nLưu ý: Tài khoản bị đóng sẽ không thể đăng nhập vào hệ thống.');
                                    } else {
                                      ref
                                          .read(usersProvider.notifier)
                                          .switchActive(account.userId!, value);
                                    }
                                  },
                            activeColor: account.role!.roleName == 'admin'
                                ? ColorName.primary.withOpacity(0.2)
                                : ColorName.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Email: ${account.email}',
                  style: TextStyle(
                    fontSize: 15,
                    color: ColorName.textNormal,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  '${context.l10n.yearOfBirth}: ${account.yob}',
                  style: TextStyle(
                    fontSize: 15,
                    color: ColorName.textNormal,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  '${context.l10n.createAt}: ${FormatSupport.toDateTimeNonSecond(account.createAt!)}',
                  style: TextStyle(
                    fontSize: 15,
                    color: ColorName.textNormal,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  margin: EdgeInsets.only(
                    top: 5,
                  ),
                  decoration: BoxDecoration(
                      color:
                          FunctionUtil.roleTitleToColor(account.role!.title!),
                      borderRadius: BorderRadius.circular(15)),
                  child: Text(
                    account.role!.title!,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
