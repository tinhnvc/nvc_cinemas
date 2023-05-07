import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/feature/m_promotion/model/promotion_model.dart';
import 'package:nvc_cinemas/feature/m_promotion/provider/promotion_provider.dart';
import 'package:nvc_cinemas/gen/assets.gen.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:nvc_cinemas/l10n/l10n.dart';
import 'package:nvc_cinemas/shared/util/format_support.dart';
import 'package:nvc_cinemas/shared/util/function_ulti.dart';
import 'package:nvc_cinemas/shared/util/init_util.dart';
import 'package:nvc_cinemas/shared/widget/snack_bar_support.dart';

class MPromotionItem extends ConsumerWidget {
  const MPromotionItem({required this.promotion, Key? key}) : super(key: key);
  final PromotionModel promotion;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    final inset = MediaQuery.of(context).viewInsets;
    final height = size.height - (padding.top + padding.bottom + inset.bottom);
    final width = size.width - (padding.left + padding.right + inset.right);
    final ratio = height / size.width;

    return GestureDetector(
      onLongPress: !promotion.active!
          ? () {
              FunctionUtil.confirmDelete(
                  onPressedConfirm: () {
                    ref.read(promotionsProvider.notifier).remove(promotion.id!);
                  },
                  content: 'Ưu đãi này?');
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
            Container(
              height: 120,
              width: 100,
              margin: const EdgeInsets.only(right: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
              child: promotion.image != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: promotion.image!.contains('/p/')
                          ? Image.asset(
                              promotion.image!,
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              File(promotion.image!),
                              fit: BoxFit.cover,
                            ),
                    )
                  : Assets.images.logoPng
                      .image(width: 100, fit: BoxFit.contain),
            ),
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
                          promotion.name ?? context.l10n.notUpdated,
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
                              InitUtil.initEditPromotion(
                                  ref: ref, promotion: promotion);
                              Navigator.pushNamed(context, '/edit-promotion',
                                  arguments: promotion);
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
                              value: promotion.active ?? false,
                              onChanged: (bool value) {
                                if (!value) {
                                  FunctionUtil.alertPopUpConfirmWithContent(
                                      onPressedConfirm: () {
                                        ref
                                            .read(promotionsProvider.notifier)
                                            .switchActive(promotion.id!, value);
                                      },
                                      content: 'Ưu đãi');
                                } else {
                                  ref
                                      .read(promotionsProvider.notifier)
                                      .switchActive(promotion.id!, value);
                                }
                              },
                              activeColor: ColorName.primary,
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
                    '${context.l10n.createAt}: ${FormatSupport.toDateTimeNonSecond(promotion.createAt!)}',
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
