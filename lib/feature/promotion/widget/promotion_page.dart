import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/feature/m_promotion/model/promotion_model.dart';
import 'package:nvc_cinemas/feature/m_promotion/provider/promotion_provider.dart';
import 'package:nvc_cinemas/feature/promotion/widget/promotion_widget.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:nvc_cinemas/l10n/l10n.dart';
import 'package:nvc_cinemas/shared/provider/user_provider.dart';
import 'package:nvc_cinemas/shared/widget/arrow_back_title.dart';

class PromotionPage extends ConsumerWidget {
  const PromotionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    final inset = MediaQuery.of(context).viewInsets;
    final height = size.height - (padding.top + padding.bottom + inset.bottom);
    final width = size.width - (padding.left + padding.right + inset.right);
    final ratio = height / size.width;
    final user = ref.watch(userProvider);
    final promotions = ref.watch(promotionsProvider)
      ..sort(
        (a, b) => -a.startTime!.compareTo(b.startTime!),
      );
    final promotionsActive = <PromotionModel>[];
    for (final item in promotions) {
      if (item.active!) {
        promotionsActive.add(item);
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: ColorName.pageBackground,
      // endDrawer: const EndDrawerWidget(),
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
                      title: context.l10n.newAndPromotion,
                      textSize: 19,
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          '${context.l10n.news.toUpperCase()} & ${context.l10n.promotions.toUpperCase()}',
                          style: TextStyle(
                            color: ColorName.btnText,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    promotionsActive.isNotEmpty
                        ? Column(
                            children: promotionsActive
                                .map((e) => PromotionWidget(promotion: e))
                                .toList(),
                          )
                        : Text(
                            'Chưa có chương chình khuyến mãi nào.\nQuý khách vui lòng quay lại sau',
                            style: TextStyle(
                              fontSize: 17,
                              color: ColorName.textNormal,
                              fontWeight: FontWeight.w600,
                            ),
                          )
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
