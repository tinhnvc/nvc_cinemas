import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/feature/m_room/model/room_model.dart';
import 'package:nvc_cinemas/feature/m_room/provider/m_room_provider.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:nvc_cinemas/l10n/l10n.dart';
import 'package:nvc_cinemas/shared/util/format_support.dart';
import 'package:nvc_cinemas/shared/util/function_ulti.dart';

class MRoomItem extends ConsumerWidget {
  const MRoomItem({required this.room, Key? key}) : super(key: key);
  final RoomModel room;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    final inset = MediaQuery.of(context).viewInsets;
    final height = size.height - (padding.top + padding.bottom + inset.bottom);
    final width = size.width - (padding.left + padding.right + inset.right);
    final ratio = height / size.width;

    return Container(
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
                        room.name ?? context.l10n.notUpdated,
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
                          onTap: () =>
                              Navigator.pushNamed(context, '/edit-room'),
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
                            value: room.active ?? false,
                            onChanged: (bool value) {
                              if (!value) {
                                FunctionUtil.alertPopUpConfirmWithContent(
                                    onPressedConfirm: () {
                                      ref
                                          .read(roomsProvider.notifier)
                                          .switchActive(room.id!, value);
                                    },
                                    content:
                                        'Phòng?\nPhòng sau khi đóng sẽ không thể chọn để book lịch chiếu');
                              } else {
                                ref
                                    .read(roomsProvider.notifier)
                                    .switchActive(room.id!, value);
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
                  '${context.l10n.seatAmount}: ${room.seatAmount} ${context.l10n.seat.toLowerCase()}',
                  style: TextStyle(
                    fontSize: 15,
                    color: ColorName.textNormal,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  '${context.l10n.size}: ${room.size}',
                  style: TextStyle(
                    fontSize: 15,
                    color: ColorName.textNormal,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  '${context.l10n.createAt}: ${FormatSupport.toDateTimeNonSecond(room.createAt!)}',
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
    );
  }
}
