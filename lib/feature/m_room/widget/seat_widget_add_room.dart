import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/feature/m_room/model/seat_model.dart';
import 'package:nvc_cinemas/feature/m_seat/provider/seat_type_provider.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:nvc_cinemas/l10n/l10n.dart';

class SeatWidgetAddRoom extends ConsumerWidget {
  const SeatWidgetAddRoom({
    required this.seat,
    Key? key,
  }) : super(key: key);
  final SeatModel seat;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allSeatsType = ref.watch(seatTypesProvider);
    final seatTypes = <String>[];
    for (final item in allSeatsType) {
      if (item.active ?? false) {
        seatTypes.add(item.typeName ?? 'Ghế thường');
      }
    }
    final isNormal = seat.seatTypeId == '212c58aa-c7c1-4de8-b3c9-75103eca4a7e';

    return PopupMenuButton(
      itemBuilder: (context) => seatTypes.map((e) {
        return buildPopupMenuItem(
          title: e,
          isChose: false,
          onPressed: () {},
        );
      }).toList(),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Column(
              children: [
                Container(
                  width: 27,
                  height: 20,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 2,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: isNormal
                        ? BorderRadius.all(
                            Radius.circular(10),
                          )
                        : BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                  ),
                  child: Center(
                    child: FittedBox(
                      child: Text(
                        seat.position.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 27,
                  height: 2,
                  margin: const EdgeInsets.only(top: 1),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                  ),
                ),
                if (!isNormal)
                  Container(
                    width: 25,
                    height: 2,
                    margin: const EdgeInsets.only(top: 1),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                    ),
                  ),
              ],
            ),
            const SizedBox(
              width: 20,
            ),
          ],
        ),
      ),
    );
  }

  PopupMenuItem buildPopupMenuItem({
    required String title,
    required bool isChose,
    required VoidCallback onPressed,
  }) {
    return PopupMenuItem(
      onTap: isChose ? null : onPressed,
      child: Row(
        children: [
          Icon(
            Icons.chair,
            size: 19,
            color: isChose ? ColorName.primary : const Color(0xFF4B5574),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: isChose ? ColorName.primary : const Color(0xFF4B5574),
                fontWeight: isChose ? FontWeight.w600 : null,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
