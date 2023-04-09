import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:nvc_cinemas/l10n/l10n.dart';

class SeatTitleWidget extends ConsumerWidget {
  const SeatTitleWidget({
    this.seatPosition,
    required this.color,
    required this.seatTitle,
    Key? key,
  }) : super(key: key);

  final String? seatPosition;
  final Color color;
  final String seatTitle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Column(
            children: [
              Container(
                width: 30,
                height: 20,
                padding: const EdgeInsets.symmetric(
                  horizontal: 2,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                child: seatPosition != null
                    ? Center(
                        child: Text(
                          seatPosition ?? 'A1',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: ColorName.btnText,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : null,
              ),
              Container(
                width: 30,
                height: 5,
                margin: const EdgeInsets.only(top: 3),
                decoration: BoxDecoration(
                  color: color,
                ),
              )
            ],
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            seatTitle,
            style: TextStyle(
              color: ColorName.btnText,
              fontSize: 14,
            ),
          )
        ],
      ),
    );
  }
}
