import 'dart:io';
import 'dart:ui';

import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/feature/m_promotion/model/promotion_model.dart';
import 'package:nvc_cinemas/gen/assets.gen.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:nvc_cinemas/l10n/l10n.dart';
import 'package:nvc_cinemas/shared/util/format_support.dart';
import 'package:nvc_cinemas/shared/widget/arrow_back_title.dart';
import 'package:nvc_cinemas/shared/widget/rounded_button_widget.dart';
import 'package:nvc_cinemas/shared/widget/snack_bar_support.dart';

class PromotionDetail extends ConsumerWidget {
  const PromotionDetail({required this.promotion, Key? key}) : super(key: key);
  final PromotionModel promotion;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    final inset = MediaQuery.of(context).viewInsets;
    final height = size.height - (padding.top + padding.bottom + inset.bottom);
    final width = size.width - (padding.left + padding.right + inset.right);
    final ratio = height / size.width;

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
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new ExactAssetImage('assets/images/promotions.png'),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        ArrowBackTitle(
                          title: context.l10n.newAndPromotion,
                          textSize: 19,
                          onPressed: () => Navigator.pop(context),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              height: 200,
                              width: 150,
                              margin: const EdgeInsets.only(right: 15),
                              decoration: BoxDecoration(
                                color: Colors.white54,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6)),
                              ),
                              child: promotion.image != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.file(
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
                                    '${context.l10n.from}: ${FormatSupport.toDateTimeNonSecond(promotion.startTime!)}',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: ColorName.textNormal,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '${context.l10n.to}: ${FormatSupport.toDateTimeNonSecond(promotion.endTime!)}',
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
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          promotion.content ?? context.l10n.notUpdated,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: 15,
                            color: ColorName.textNormal,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        if (promotion.code != null &&
                            promotion.code!.isNotEmpty)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${context.l10n.couponCode}: ${promotion.code}',
                                style: TextStyle(
                                  color: ColorName.btnText,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              RoundedButtonWidget(
                                content: context.l10n.copy,
                                onPressed: () async {
                                  await FlutterClipboard.copy(promotion.code!);
                                  SnackBarSupport.copied(context: context);
                                },
                              ),
                            ],
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
}
