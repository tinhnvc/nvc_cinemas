import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/feature/m_category/provider/category_provider.dart';
import 'package:nvc_cinemas/feature/m_movie/provider/m_movie_provider.dart';
import 'package:nvc_cinemas/feature/m_seat/provider/seat_provider.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:nvc_cinemas/l10n/l10n.dart';
import 'package:nvc_cinemas/shared/provider/user_provider.dart';
import 'package:nvc_cinemas/shared/util/function_ulti.dart';
import 'package:nvc_cinemas/shared/widget/arrow_back_title.dart';
import 'package:nvc_cinemas/shared/widget/dropdown_widget.dart';
import 'package:nvc_cinemas/shared/widget/form_text_field.dart';
import 'package:nvc_cinemas/shared/widget/information_card.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class AddSeat extends ConsumerWidget {
  const AddSeat({Key? key}) : super(key: key);

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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    ArrowBackTitle(
                      title:
                          '${context.l10n.addNew} ${context.l10n.seat.toLowerCase()}',
                      textSize: 19,
                      onPressed: () => Navigator.pop(context),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 15,
                      ),
                      child: ReactiveForm(
                        formGroup: ref.read(seatFormProvider).addSeatForm,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              context.l10n.seatName,
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
                                  formControlName: 'typeName',
                                  maxLine: 1,
                                  textInputAction: TextInputAction.next,
                                  labelText:
                                      '${context.l10n.input} ${context.l10n.seatName.toLowerCase()}'),
                            ),
                            Text(
                              context.l10n.price,
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
                                  formControlName: 'price',
                                  maxLine: 1,
                                  textInputType: TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                  labelText: '${context.l10n.input} '
                                      '${context.l10n.price.toLowerCase()}'),
                            ),
                            Text(
                              '${context.l10n.otherPrice}',
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
                                  formControlName: 'otherPrice',
                                  maxLine: 1,
                                  textInputType: TextInputType.number,
                                  textInputAction: TextInputAction.done,
                                  labelText: '${context.l10n.input} '
                                      '${context.l10n.otherPrice.toLowerCase()}'),
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
                                        .watch(seatFormProvider)
                                        .buttonController,
                                    onPressed: () {
                                      ref
                                          .read(seatFormProvider)
                                          .addSeat(ref, context);
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
