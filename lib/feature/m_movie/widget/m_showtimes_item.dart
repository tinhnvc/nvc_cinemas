import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/feature/m_movie/model/time_model.dart';
import 'package:nvc_cinemas/feature/m_room/provider/m_room_provider.dart';
import 'package:nvc_cinemas/feature/m_room/provider/m_seat_provider.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:nvc_cinemas/l10n/l10n.dart';
import 'package:nvc_cinemas/shared/util/format_support.dart';
import 'package:nvc_cinemas/shared/widget/call_modal_sheet.dart';

class MShowtimesItem extends ConsumerWidget {
  const MShowtimesItem({required this.time, Key? key}) : super(key: key);
  final TimeModel time;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    final inset = MediaQuery.of(context).viewInsets;
    final height = size.height - (padding.top + padding.bottom + inset.bottom);
    final width = size.width - (padding.left + padding.right + inset.right);
    final ratio = height / size.width;
    final room = ref.read(roomsProvider.notifier).getById(time.roomId!);
    final emptySeats =
        ref.read(seatsProvider.notifier).getSeatEmptyAmount(ref, time);

    return Container(
      decoration: BoxDecoration(
        color: ColorName.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    '${FormatSupport.toDateTimeNonDate(time.from!)}',
                    style: TextStyle(
                      color: ColorName.btnText,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    '${room.name}',
                    style: TextStyle(
                      color: ColorName.btnText,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    '$emptySeats ${context.l10n.emptySeat.toLowerCase()}',
                    style: TextStyle(
                      color: ColorName.btnText,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Text(
                    '${context.l10n.endTime}: ${FormatSupport.toDateTimeNonDate(time.to!)}',
                    style: TextStyle(
                      color: ColorName.btnText,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () => CallModalSheet.editShowtimes(context),
                child: Icon(
                  Icons.edit_calendar,
                  size: 27,
                  color: ColorName.primary,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Icon(
                Icons.delete_forever,
                size: 27,
                color: ColorName.primary,
              ),
            ],
          )
        ],
      ),
    );
  }
}
