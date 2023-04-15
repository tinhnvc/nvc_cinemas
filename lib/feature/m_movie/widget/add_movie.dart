import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/feature/m_category/provider/category_provider.dart';
import 'package:nvc_cinemas/feature/m_movie/provider/m_movie_provider.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:nvc_cinemas/l10n/l10n.dart';
import 'package:nvc_cinemas/shared/widget/arrow_back_title.dart';
import 'package:nvc_cinemas/shared/widget/dropdown_widget.dart';
import 'package:nvc_cinemas/shared/widget/form_text_field.dart';
import 'package:nvc_cinemas/shared/widget/information_card.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class AddMovie extends ConsumerWidget {
  const AddMovie({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    final inset = MediaQuery.of(context).viewInsets;
    final height = size.height - (padding.top + padding.bottom + inset.bottom);
    final width = size.width - (padding.left + padding.right + inset.right);
    final ratio = height / size.width;

    final categoriesDropdownList = [
      'Tâm lý',
      'Hành động',
      'Tình cảm',
      'Võ thuật',
    ];

    final ageTypeDropdownList = [
      'P-', // all
      'T13-',
      'T16-',
      'T18-', // 18 tuổi trở lên
      'C-', // không phổ biến
      'K-', // dưới 13, có bố mẹ
    ];

    final categoryValue = ref.watch(categoryAddMovieProvider);
    final ageTypeValue = ref.watch(ageTypeAddMovieProvider);

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
                          '${context.l10n.addNew} ${context.l10n.movie.toLowerCase()}',
                      textSize: 19,
                      onPressed: () => Navigator.pop(context),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 15,
                      ),
                      child: ReactiveForm(
                        formGroup: ref.read(movieFormProvider).addMovieForm,
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
                            Container(
                              width: 120,
                              height: 150,
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: ColorName.primary,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.add_photo_alternate_outlined,
                                  size: 30,
                                  color: ColorName.primary,
                                ),
                              ),
                            ),
                            Text(
                              context.l10n.movieNameVi,
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
                                  formControlName: 'movieNameVi',
                                  maxLine: 1,
                                  textInputAction: TextInputAction.next,
                                  labelText: '${context.l10n.input} '
                                      '${context.l10n.movieNameVi}'),
                            ),
                            Text(
                              context.l10n.movieNameEn,
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
                                  formControlName: 'movieNameEn',
                                  maxLine: 1,
                                  textInputAction: TextInputAction.next,
                                  labelText: '${context.l10n.input} '
                                      '${context.l10n.movieNameEn}'),
                            ),
                            Text(
                              context.l10n.categories,
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
                                value: categoryValue.isNotEmpty
                                    ? categoryValue
                                    : 'Tâm lý',
                                values: categoriesDropdownList,
                                onChanged: (String value) {
                                  ref
                                      .read(categoryAddMovieProvider.notifier)
                                      .update(value);
                                },
                              ),
                            ),
                            Text(
                              context.l10n.age,
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
                                value: ageTypeValue.isNotEmpty
                                    ? ageTypeValue
                                    : 'P-',
                                values: ageTypeDropdownList,
                                onChanged: (String value) {
                                  ref
                                      .read(ageTypeAddMovieProvider.notifier)
                                      .update(value);
                                },
                              ),
                            ),
                            Text(
                              context.l10n.description,
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
                                formControlName: 'description',
                                maxLine: 5,
                                textInputAction: TextInputAction.newline,
                                labelText: context.l10n.descriptionHint,
                              ),
                            ),
                            Text(
                              context.l10n.runTime,
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
                                  formControlName: 'duration',
                                  maxLine: 1,
                                  textInputAction: TextInputAction.next,
                                  textInputType: TextInputType.number,
                                  labelText: '${context.l10n.input} '
                                      '${context.l10n.runTime.toLowerCase()}'),
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
                                            context.l10n.releaseShow,
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
                                            content: '12/02/2023',
                                            onPressed: () {},
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
                                            context.l10n.endShow,
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
                                            content: '22/02/2023',
                                            onPressed: () {},
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
                              context.l10n.director,
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
                                  formControlName: 'director',
                                  maxLine: 1,
                                  textInputAction: TextInputAction.next,
                                  textInputType: TextInputType.number,
                                  labelText: '${context.l10n.input} '
                                      '${context.l10n.director.toLowerCase()}'),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              context.l10n.cast,
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
                                  formControlName: 'actor',
                                  maxLine: 3,
                                  textInputAction: TextInputAction.next,
                                  textInputType: TextInputType.number,
                                  labelText: '${context.l10n.input} '
                                      '${context.l10n.cast.toLowerCase()}'),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                bottom: 25,
                              ),
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
                                        .watch(movieFormProvider)
                                        .buttonController,
                                    onPressed: () {
                                      ref
                                          .read(movieFormProvider)
                                          .addMovie(ref, context);
                                    },
                                    child: Text(
                                      context.l10n.addNew,
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
