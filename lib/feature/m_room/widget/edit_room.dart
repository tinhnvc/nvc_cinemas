import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/feature/m_category/provider/category_provider.dart';
import 'package:nvc_cinemas/feature/m_movie/provider/m_movie_provider.dart';
import 'package:nvc_cinemas/feature/m_room/provider/m_room_provider.dart';
import 'package:nvc_cinemas/feature/m_room/widget/seat_widget_add_room.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:nvc_cinemas/l10n/l10n.dart';
import 'package:nvc_cinemas/shared/widget/arrow_back_title.dart';
import 'package:nvc_cinemas/shared/widget/form_text_field.dart';
import 'package:nvc_cinemas/shared/widget/select/seat_widget.dart';
import 'package:nvc_cinemas/shared/widget/time_create_and_update.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class EditRoom extends ConsumerWidget {
  const EditRoom({Key? key}) : super(key: key);

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
                      title: context.l10n.editRoom,
                      textSize: 19,
                      onPressed: () => Navigator.pop(context),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 15,
                      ),
                      child: ReactiveForm(
                        formGroup: ref.read(roomFormProvider).addRoomForm,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              context.l10n.roomName,
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
                                  formControlName: 'roomName',
                                  maxLine: 1,
                                  textInputAction: TextInputAction.next,
                                  labelText: '${context.l10n.input} '
                                      '${context.l10n.roomName.toLowerCase()}'),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        context.l10n.sizeW,
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
                                            formControlName: 'sizeW',
                                            maxLine: 1,
                                            textInputAction:
                                            TextInputAction.next,
                                            labelText: '${context.l10n.input} '
                                                '${context.l10n.sizeW.toLowerCase()}'),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        context.l10n.sizeH,
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
                                            formControlName: 'sizeH',
                                            maxLine: 1,
                                            textInputAction:
                                            TextInputAction.next,
                                            labelText: '${context.l10n.input} '
                                                '${context.l10n.sizeH.toLowerCase()}'),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              '${context.l10n.seatAmount}: 24',
                              style: const TextStyle(
                                color: Color(0xFF363E59),
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 210,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    color: ColorName.btnText,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SeatWidgetAddRoom(
                                  color: Colors.grey,
                                  isNormal: true,
                                ),
                                SeatWidgetAddRoom(
                                  color: Colors.grey,
                                  isNormal: true,
                                ),
                                SeatWidgetAddRoom(
                                  color: Colors.grey,
                                  isNormal: true,
                                ),
                                SeatWidgetAddRoom(
                                  color: Colors.grey,
                                  isNormal: true,
                                ),
                                SeatWidgetAddRoom(
                                  color: Colors.grey,
                                  isNormal: true,
                                ),
                                SeatWidgetAddRoom(
                                  color: Colors.grey,
                                  isNormal: true,
                                ),
                                SeatWidgetAddRoom(
                                  color: Colors.grey,
                                  isNormal: true,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SeatWidgetAddRoom(
                                  color: Colors.grey,
                                  isNormal: true,
                                ),
                                SeatWidgetAddRoom(
                                  color: Colors.grey,
                                  isNormal: true,
                                ),
                                SeatWidgetAddRoom(
                                  color: Colors.grey,
                                  isNormal: true,
                                ),
                                SeatWidgetAddRoom(
                                  color: Colors.grey,
                                  isNormal: true,
                                ),
                                SeatWidgetAddRoom(
                                  color: Colors.grey,
                                  isNormal: true,
                                ),
                                SeatWidgetAddRoom(
                                  color: Colors.grey,
                                  isNormal: true,
                                ),
                                SeatWidgetAddRoom(
                                  color: Colors.grey,
                                  isNormal: true,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SeatWidgetAddRoom(
                                  color: Colors.grey,
                                  isNormal: false,
                                ),
                                SeatWidgetAddRoom(
                                  color: Colors.grey,
                                  isNormal: false,
                                ),
                                SeatWidgetAddRoom(
                                  color: Colors.grey,
                                  isNormal: false,
                                ),
                                SeatWidgetAddRoom(
                                  color: Colors.grey,
                                  isNormal: false,
                                ),
                                SeatWidgetAddRoom(
                                  color: Colors.grey,
                                  isNormal: false,
                                ),
                                SeatWidgetAddRoom(
                                  color: Colors.grey,
                                  isNormal: false,
                                ),
                                SeatWidgetAddRoom(
                                  color: Colors.grey,
                                  isNormal: false,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SeatWidgetAddRoom(
                                  color: Colors.grey,
                                  isNormal: false,
                                ),
                                SeatWidgetAddRoom(
                                  color: Colors.grey,
                                  isNormal: false,
                                ),
                                SeatWidgetAddRoom(
                                  color: Colors.grey,
                                  isNormal: false,
                                ),
                                SeatWidgetAddRoom(
                                  color: Colors.grey,
                                  isNormal: false,
                                ),
                                SeatWidgetAddRoom(
                                  color: Colors.grey,
                                  isNormal: false,
                                ),
                                SeatWidgetAddRoom(
                                  color: Colors.grey,
                                  isNormal: false,
                                ),
                                SeatWidgetAddRoom(
                                  color: Colors.grey,
                                  isNormal: false,
                                ),
                              ],
                            ),
                            TimeCrateAndUpdate(
                              createTime: 1676352825000,
                              updateTime: 1676539365000,
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
                                        .watch(categoryFormProvider)
                                        .buttonController,
                                    onPressed: () {
                                      ref
                                          .read(categoryFormProvider)
                                          .addCategory(ref, context);
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
