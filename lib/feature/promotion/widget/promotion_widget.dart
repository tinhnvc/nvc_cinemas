import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/feature/m_promotion/model/promotion_model.dart';
import 'package:nvc_cinemas/gen/assets.gen.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:nvc_cinemas/l10n/l10n.dart';
import 'package:nvc_cinemas/shared/util/format_support.dart';

class PromotionWidget extends ConsumerWidget {
  const PromotionWidget({required this.promotion, Key? key}) : super(key: key);
  final PromotionModel promotion;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/promotion-detail',
          arguments: promotion),
      child: Container(
        margin: const EdgeInsets.only(top: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              height: 150,
              width: 100,
              margin: const EdgeInsets.only(right: 15),
              decoration: BoxDecoration(
                color: Colors.white54,
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
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    promotion.name ?? context.l10n.notUpdated,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 17,
                      color: ColorName.textNormal,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    FormatSupport.toDateTime(promotion.startTime!),
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
