import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/feature/m_seat/model/seat_type_model.dart';
import 'package:nvc_cinemas/feature/m_seat/provider/seat_type_provider.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:nvc_cinemas/l10n/l10n.dart';
import 'package:nvc_cinemas/shared/util/format_support.dart';
import 'package:nvc_cinemas/shared/util/function_ulti.dart';
import 'package:nvc_cinemas/shared/util/init_util.dart';
import 'package:nvc_cinemas/shared/widget/snack_bar_support.dart';

class MSeatItem extends ConsumerWidget {
  const MSeatItem({required this.seatType, Key? key}) : super(key: key);
  final SeatTypeModel seatType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    final inset = MediaQuery.of(context).viewInsets;
    final height = size.height - (padding.top + padding.bottom + inset.bottom);
    final width = size.width - (padding.left + padding.right + inset.right);
    final ratio = height / size.width;

    return GestureDetector(
      onLongPress: !seatType.active!
          ? () {
              FunctionUtil.confirmDelete(
                  onPressedConfirm: () {
                    ref.read(seatTypesProvider.notifier).remove(seatType.id!);
                  },
                  content: 'Loại ghế này?');
            }
          : () {
              SnackBarSupport.avoidFunction(
                context: context,
                hideAction: true,
              );
            },
      child: Container(
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
                          seatType.typeName ?? context.l10n.notUpdated,
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
                            onTap: () {
                              InitUtil.initEditSeatType(
                                  ref: ref, seatType: seatType);
                              Navigator.pushNamed(context, '/edit-seat',
                                  arguments: seatType);
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
                              value: seatType.active ?? false,
                              onChanged: seatType.isDefault ?? false
                                  ? (bool value) {
                                      SnackBarSupport.avoidFunction(
                                        context: context,
                                        hideAction: true,
                                      );
                                    }
                                  : (bool value) {
                                      if (!value) {
                                        FunctionUtil
                                            .alertPopUpConfirmWithContent(
                                                onPressedConfirm: () {
                                                  ref
                                                      .read(seatTypesProvider
                                                          .notifier)
                                                      .switchActive(
                                                          seatType.id!, value);
                                                },
                                                content: 'Loại ghế');
                                      } else {
                                        ref
                                            .read(seatTypesProvider.notifier)
                                            .switchActive(seatType.id!, value);
                                      }
                                    },
                              activeColor: seatType.isDefault ?? false
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
                    '${context.l10n.price}: ${FormatSupport.toMoney(seatType.price!)}đ',
                    style: TextStyle(
                      fontSize: 15,
                      color: ColorName.textNormal,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${context.l10n.createAt}: ${FormatSupport.toDateTimeNonSecond(seatType.createAt!)}',
                    style: TextStyle(
                      fontSize: 15,
                      color: ColorName.textNormal,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
