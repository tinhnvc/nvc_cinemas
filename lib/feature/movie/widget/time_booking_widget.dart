import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';

class TimeBookingWidget extends ConsumerWidget {
  const TimeBookingWidget({
    required this.time,
    required this.seat,
    Key? key,
  }) : super(key: key);
  final String time;
  final String seat;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.only(right: 25),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 3),
            decoration: BoxDecoration(
              color: ColorName.primary.withOpacity(0.3),
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(6),
                right: Radius.circular(6),
              ),
            ),
            child: Text(
              time,
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
            seat,
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
