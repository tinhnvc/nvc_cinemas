import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/feature/m_room/model/seat_model.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:nvc_cinemas/l10n/l10n.dart';

class SeatWidget extends ConsumerWidget {
  const SeatWidget({
    required this.seat,
    // required this.seatPosition,
    // required this.color,
    // required this.isNormal,
    Key? key,
  }) : super(key: key);

  final SeatModel seat;

  // final String seatPosition;
  // final Color color;
  // final bool isNormal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isNormal = seat.seatTypeId == '212c58aa-c7c1-4de8-b3c9-75103eca4a7e';

    return Container(
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
                  color: seat.isSold ?? false
                      ? Colors.red
                      : seat.isSelected ?? false
                          ? ColorName.primary
                          : Colors.grey,
                  borderRadius:
                      seat.seatTypeId == '212c58aa-c7c1-4de8-b3c9-75103eca4a7e'
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
                  color: seat.isSold ?? false
                      ? Colors.red
                      : seat.isSelected ?? false
                          ? ColorName.primary
                          : Colors.grey,
                ),
              ),
              if (!isNormal)
                Container(
                  width: 25,
                  height: 2,
                  margin: const EdgeInsets.only(top: 1),
                  decoration: BoxDecoration(
                    color: seat.isSold ?? false
                        ? Colors.red
                        : seat.isSelected ?? false
                            ? ColorName.primary
                            : Colors.grey,
                  ),
                ),
            ],
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }
}
