import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:nvc_cinemas/l10n/l10n.dart';

class SeatTypeWidget extends ConsumerWidget {
  const SeatTypeWidget({
    required this.color,
    required this.seatType,
    required this.price,
    required this.isNormal,
    Key? key,
  }) : super(key: key);

  final Color color;
  final String seatType;
  final String price;
  final bool isNormal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 25,
                height: 20,
                padding: const EdgeInsets.symmetric(
                  horizontal: 2,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: isNormal
                      ? BorderRadius.all(
                          Radius.circular(10),
                        )
                      : BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                ),
              ),
              Container(
                width: 25,
                height: 2,
                margin: const EdgeInsets.only(top: 1),
                decoration: BoxDecoration(
                  color: color,
                ),
              ),
              if (!isNormal)
                Container(
                  width: 25,
                  height: 2,
                  margin: const EdgeInsets.only(top: 1),
                  decoration: BoxDecoration(
                    color: color,
                  ),
                ),
            ],
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  seatType,
                  style: TextStyle(
                    color: ColorName.btnText,
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Text(
                  price,
                  style: TextStyle(
                    color: ColorName.btnText,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
