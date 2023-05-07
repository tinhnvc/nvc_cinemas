import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/feature/m_category/provider/category_provider.dart';
import 'package:nvc_cinemas/feature/m_movie/provider/m_movie_provider.dart';
import 'package:nvc_cinemas/feature/m_promotion/model/promotion_model.dart';
import 'package:nvc_cinemas/feature/m_promotion/provider/promotion_provider.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:nvc_cinemas/l10n/l10n.dart';
import 'package:nvc_cinemas/shared/service/file_service.dart';
import 'package:nvc_cinemas/shared/util/date_time_picker.dart';
import 'package:nvc_cinemas/shared/util/format_support.dart';
import 'package:nvc_cinemas/shared/widget/arrow_back_title.dart';
import 'package:nvc_cinemas/shared/widget/dropdown_widget.dart';
import 'package:nvc_cinemas/shared/widget/form_text_field.dart';
import 'package:nvc_cinemas/shared/widget/information_card.dart';
import 'package:nvc_cinemas/shared/widget/time_create_and_update.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class EditPromotion extends ConsumerWidget {
  const EditPromotion({required this.promotion, Key? key}) : super(key: key);
  final PromotionModel promotion;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    final inset = MediaQuery.of(context).viewInsets;
    final height = size.height - (padding.top + padding.bottom + inset.bottom);
    final width = size.width - (padding.left + padding.right + inset.right);
    final ratio = height / size.width;

    final promotionCodeList = [
      'Chọn mã',
      'COU10',
      'COU15',
      'COU20',
      'COU30',
      'DANGO45',
      'DANGO55',
      'DANGO65',
      'DANGO75',
    ];
    final codeValue = ref.watch(codeAddPromotionProvider);
    final formGroup = ref.read(promotionFormProvider).addPromotionForm;
    final pathValue = ref.watch(imageAddPromotionProvider);
    var timeFrom = ref.watch(startTimeAddPromotionProvider);
    var timeTo = ref.watch(endTimeAddPromotionProvider);

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
                          '${context.l10n.edit} ${context.l10n.promotions.toLowerCase()}',
                      textSize: 19,
                      onPressed: () => Navigator.pop(context),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 15,
                      ),
                      child: ReactiveForm(
                        formGroup:
                            ref.read(promotionFormProvider).addPromotionForm,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              context.l10n.avatarBanner,
                              style: const TextStyle(
                                color: Color(0xFF363E59),
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                final imagePath = await FileService.pickImage();
                                if (imagePath.isNotEmpty) {
                                  ref
                                      .read(imageAddPromotionProvider.notifier)
                                      .update(imagePath);
                                  formGroup.control('image').value = imagePath;
                                }
                              },
                              child: Container(
                                width: 120,
                                height: 150,
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: ColorName.primary,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: pathValue.isNotEmpty
                                    ? ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: pathValue.contains('/p/')
                                            ? Image.asset(
                                                pathValue,
                                                fit: BoxFit.cover,
                                              )
                                            : Image.file(
                                                File(pathValue),
                                                fit: BoxFit.cover,
                                              ),
                                      )
                                    : Center(
                                        child: Icon(
                                          Icons.add_photo_alternate_outlined,
                                          size: 30,
                                          color: ColorName.primary,
                                        ),
                                      ),
                              ),
                            ),
                            Text(
                              context.l10n.promotionName,
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
                                  formControlName: 'name',
                                  maxLine: 1,
                                  textInputAction: TextInputAction.next,
                                  labelText: '${context.l10n.input} '
                                      '${context.l10n.promotionName.toLowerCase()}'),
                            ),
                            Text(
                              context.l10n.content,
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
                                  formControlName: 'content',
                                  maxLine: 3,
                                  textInputAction: TextInputAction.done,
                                  labelText: '${context.l10n.input} '
                                      '${context.l10n.content.toLowerCase()}'),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            context.l10n.startTime,
                                            style: const TextStyle(
                                              color: Color(0xFF363E59),
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          InformationCard(
                                            content: timeFrom != '0'
                                                ? FormatSupport
                                                    .toDateTimeNonHour(
                                                    int.parse(timeFrom),
                                                  )
                                                : context.l10n.chooseStartDate,
                                            onPressed: () async {
                                              final dateRange =
                                                  await DateTimePicker
                                                      .pickDateRange(
                                                context: context,
                                                start: int.parse(timeFrom),
                                                end: int.parse(timeTo),
                                              );
                                              timeFrom = dateRange
                                                  .start.millisecondsSinceEpoch
                                                  .toString();
                                              ref
                                                  .read(
                                                      startTimeAddPromotionProvider
                                                          .notifier)
                                                  .update(timeFrom);
                                              formGroup
                                                  .control('startTime')
                                                  .value = timeFrom;

                                              timeTo = (dateRange.end
                                                          .add(const Duration(
                                                              days: 1))
                                                          .millisecondsSinceEpoch -
                                                      1)
                                                  .toString();
                                              ref
                                                  .read(
                                                      endTimeAddPromotionProvider
                                                          .notifier)
                                                  .update(timeTo);
                                              formGroup
                                                  .control('endTime')
                                                  .value = timeTo;
                                            },
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Icon(
                                        Icons.date_range_rounded,
                                        size: 30,
                                        color: ColorName.primary,
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            context.l10n.endTime,
                                            style: const TextStyle(
                                              color: Color(0xFF363E59),
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          InformationCard(
                                            content: timeFrom != '0'
                                                ? FormatSupport
                                                    .toDateTimeNonHour(
                                                    int.parse(timeTo),
                                                  )
                                                : context.l10n.chooseToDate,
                                            onPressed: () async {
                                              final dateRange =
                                                  await DateTimePicker
                                                      .pickDateRange(
                                                context: context,
                                                start: int.parse(timeFrom),
                                                end: int.parse(timeTo),
                                              );
                                              timeFrom = dateRange
                                                  .start.millisecondsSinceEpoch
                                                  .toString();
                                              ref
                                                  .read(
                                                      startTimeAddPromotionProvider
                                                          .notifier)
                                                  .update(timeFrom);
                                              formGroup
                                                  .control('startTime')
                                                  .value = timeFrom;

                                              timeTo = (dateRange.end
                                                          .add(const Duration(
                                                              days: 1))
                                                          .millisecondsSinceEpoch -
                                                      1)
                                                  .toString();
                                              ref
                                                  .read(
                                                      endTimeAddPromotionProvider
                                                          .notifier)
                                                  .update(timeTo);
                                              formGroup
                                                  .control('endTime')
                                                  .value = timeTo;
                                            },
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Icon(
                                        Icons.date_range_rounded,
                                        size: 30,
                                        color: ColorName.primary,
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
                              context.l10n.couponCode,
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
                                value: codeValue.isNotEmpty
                                    ? codeValue
                                    : 'Chọn mã',
                                values: promotionCodeList,
                                onChanged: (String value) {
                                  ref
                                      .read(codeAddPromotionProvider.notifier)
                                      .update(value);
                                  formGroup.control('code').value = value;
                                },
                              ),
                            ),
                            TimeCrateAndUpdate(
                              createTime: promotion.createAt!,
                              updateTime: promotion.updateAt!,
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
                                        .watch(promotionFormProvider)
                                        .buttonController,
                                    onPressed: () {
                                      print(formGroup.value);
                                      ref
                                          .read(promotionFormProvider)
                                          .editPromotion(
                                              ref, context, promotion);
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
