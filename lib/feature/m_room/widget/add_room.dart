import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/feature/m_room/provider/m_room_provider.dart';
import 'package:nvc_cinemas/feature/m_room/widget/seat_widget_add_room.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:nvc_cinemas/l10n/l10n.dart';
import 'package:nvc_cinemas/shared/widget/arrow_back_title.dart';
import 'package:nvc_cinemas/shared/widget/dropdown_widget.dart';
import 'package:nvc_cinemas/shared/widget/form_text_field.dart';
import 'package:nvc_cinemas/shared/widget/seat_title_widget.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class AddRoom extends ConsumerWidget {
  const AddRoom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    final inset = MediaQuery.of(context).viewInsets;
    final height = size.height - (padding.top + padding.bottom + inset.bottom);
    final width = size.width - (padding.left + padding.right + inset.right);
    final ratio = height / size.width;

    final heightDropdownList = ['2', '3', '4', '5', '6', '7', '8', '9', '10'];
    final widthDropdownList = ['2', '3', '4', '5', '6',];
    final heightValue = ref.watch(heightAddRoomProvider);
    final widthValue = ref.watch(widthAddRoomProvider);
    final formGroup = ref.read(roomFormProvider).addRoomForm;
    final seatAmount = int.parse(heightValue) * int.parse(widthValue);
    final roomId = ref.watch(roomIdProvider);
    final seatsInit = ref.watch(seatsAddRoomProvider);

    var rowList = [];
    var colList = [];
    var indexList = [];
    for (int i = 0; i < int.parse(heightValue); i++) {
      rowList.add(i + 1);
    }
    for (int i = 0; i < int.parse(widthValue); i++) {
      colList.add(i + 1);
    }
    for (int i = 0; i < seatAmount; i++) {
      indexList.add(i);
    }

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
                      title: context.l10n.addRoom,
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
                                  textInputAction: TextInputAction.done,
                                  labelText: '${context.l10n.input} '
                                      '${context.l10n.roomName.toLowerCase()}'),
                            ),
                            Text(
                              context.l10n.sizeH,
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
                                value:
                                    heightValue.isNotEmpty ? heightValue : '3',
                                values: heightDropdownList,
                                onChanged: (String value) {
                                  ref
                                      .read(heightAddRoomProvider.notifier)
                                      .update(value);
                                  ref
                                      .read(seatsAddRoomProvider.notifier)
                                      .fetchRooms(ref, int.parse(value),
                                          int.parse(widthValue));
                                  formGroup.control('seatAmount').value =
                                      '${int.parse(value) * int.parse(widthValue)}';
                                },
                              ),
                            ),
                            Text(
                              context.l10n.sizeW,
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
                                value: widthValue.isNotEmpty ? widthValue : '4',
                                values: widthDropdownList,
                                onChanged: (String value) {
                                  ref
                                      .read(widthAddRoomProvider.notifier)
                                      .update(value);
                                  ref
                                      .read(seatsAddRoomProvider.notifier)
                                      .fetchRooms(ref, int.parse(heightValue),
                                          int.parse(value));
                                  formGroup.control('seatAmount').value =
                                      '${int.parse(heightValue) * int.parse(value)}';
                                },
                              ),
                            ),
                            Text(
                              '${context.l10n.seatAmount}: $seatAmount',
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
                                  width: 170,
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
                                Container(
                                  margin: const EdgeInsets.only(left: 30),
                                  height: 300,
                                  width: 330,
                                  child: GridView.count(
                                    crossAxisCount: int.parse(widthValue),
                                    crossAxisSpacing: 5,
                                    mainAxisSpacing: 5,
                                    children: indexList
                                        .map((e) => SeatWidgetAddRoom(
                                              seat: seatsInit[e],
                                            ))
                                        .toList(),
                                  ),
                                ),
                              ],
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     SeatWidgetAddRoom(
                            //       color: Colors.grey,
                            //       isNormal: true,
                            //     ),
                            //     SeatWidgetAddRoom(
                            //       color: Colors.grey,
                            //       isNormal: true,
                            //     ),
                            //     SeatWidgetAddRoom(
                            //       color: Colors.grey,
                            //       isNormal: true,
                            //     ),
                            //     SeatWidgetAddRoom(
                            //       color: Colors.grey,
                            //       isNormal: true,
                            //     ),
                            //     SeatWidgetAddRoom(
                            //       color: Colors.grey,
                            //       isNormal: true,
                            //     ),
                            //     SeatWidgetAddRoom(
                            //       color: Colors.grey,
                            //       isNormal: true,
                            //     ),
                            //     SeatWidgetAddRoom(
                            //       color: Colors.grey,
                            //       isNormal: true,
                            //     ),
                            //   ],
                            // ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     SeatWidgetAddRoom(
                            //       color: Colors.grey,
                            //       isNormal: true,
                            //     ),
                            //     SeatWidgetAddRoom(
                            //       color: Colors.grey,
                            //       isNormal: true,
                            //     ),
                            //     SeatWidgetAddRoom(
                            //       color: Colors.grey,
                            //       isNormal: true,
                            //     ),
                            //     SeatWidgetAddRoom(
                            //       color: Colors.grey,
                            //       isNormal: true,
                            //     ),
                            //     SeatWidgetAddRoom(
                            //       color: Colors.grey,
                            //       isNormal: true,
                            //     ),
                            //     SeatWidgetAddRoom(
                            //       color: Colors.grey,
                            //       isNormal: true,
                            //     ),
                            //     SeatWidgetAddRoom(
                            //       color: Colors.grey,
                            //       isNormal: true,
                            //     ),
                            //   ],
                            // ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     SeatWidgetAddRoom(
                            //       color: Colors.grey,
                            //       isNormal: false,
                            //     ),
                            //     SeatWidgetAddRoom(
                            //       color: Colors.grey,
                            //       isNormal: false,
                            //     ),
                            //     SeatWidgetAddRoom(
                            //       color: Colors.grey,
                            //       isNormal: false,
                            //     ),
                            //     SeatWidgetAddRoom(
                            //       color: Colors.grey,
                            //       isNormal: false,
                            //     ),
                            //     SeatWidgetAddRoom(
                            //       color: Colors.grey,
                            //       isNormal: false,
                            //     ),
                            //     SeatWidgetAddRoom(
                            //       color: Colors.grey,
                            //       isNormal: false,
                            //     ),
                            //     SeatWidgetAddRoom(
                            //       color: Colors.grey,
                            //       isNormal: false,
                            //     ),
                            //   ],
                            // ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     SeatWidgetAddRoom(
                            //       color: Colors.grey,
                            //       isNormal: false,
                            //     ),
                            //     SeatWidgetAddRoom(
                            //       color: Colors.grey,
                            //       isNormal: false,
                            //     ),
                            //     SeatWidgetAddRoom(
                            //       color: Colors.grey,
                            //       isNormal: false,
                            //     ),
                            //     SeatWidgetAddRoom(
                            //       color: Colors.grey,
                            //       isNormal: false,
                            //     ),
                            //     SeatWidgetAddRoom(
                            //       color: Colors.grey,
                            //       isNormal: false,
                            //     ),
                            //     SeatWidgetAddRoom(
                            //       color: Colors.grey,
                            //       isNormal: false,
                            //     ),
                            //     SeatWidgetAddRoom(
                            //       color: Colors.grey,
                            //       isNormal: false,
                            //     ),
                            //   ],
                            // ),
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
                                        .watch(roomFormProvider)
                                        .buttonController,
                                    onPressed: () {
                                      // ref
                                      //     .read(roomFormProvider)
                                      //     .addRoom(ref, context);
                                      print(ref
                                          .watch(seatsAddRoomProvider)
                                          .length);
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
