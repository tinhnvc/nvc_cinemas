import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:nvc_cinemas/feature/m_movie/model/time_model.dart';
import 'package:nvc_cinemas/feature/m_room/provider/m_room_provider.dart';
import 'package:nvc_cinemas/feature/m_room/provider/m_seat_provider.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:nvc_cinemas/l10n/l10n.dart';
import 'package:nvc_cinemas/shared/util/format_support.dart';

class TimeBookingWidget extends ConsumerWidget {
  const TimeBookingWidget({
    required this.time,
    Key? key,
  }) : super(key: key);
  final TimeModel time;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final room = ref.read(roomsProvider.notifier).getById(time.roomId!);
    final emptySeats =
        ref.read(seatsProvider.notifier).getSeatEmptyAmount(ref, time);

    return Container(
      margin: const EdgeInsets.only(right: 25),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 3),
            decoration: BoxDecoration(
              color: ColorName.primary.withOpacity(0.5),
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(15),
                right: Radius.circular(15),
              ),
            ),
            child: Text(
              FormatSupport.toDateTimeNonDate(time.from!),
              style: TextStyle(
                color: ColorName.btnText,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            '$emptySeats ${context.l10n.empty.toLowerCase()}',
            style: TextStyle(
              color: ColorName.btnText,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
