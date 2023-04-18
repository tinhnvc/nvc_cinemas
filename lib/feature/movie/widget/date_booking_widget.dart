import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';

class DateBookingWidget extends ConsumerWidget {
  const DateBookingWidget({
    required this.date,
    required this.dayOfWeek,
    required this.isSelect,
    Key? key,
  }) : super(key: key);
  final String date;
  final String dayOfWeek;
  final bool isSelect;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 700),
      margin: const EdgeInsets.only(right: 20),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: isSelect ? ColorName.primary.withOpacity(0.5) : null,
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          Text(
            date,
            style: TextStyle(
              color: ColorName.btnText,
              fontSize: 25,
              fontWeight: isSelect ? FontWeight.bold : null,
            ),
          ),
          Text(
            dayOfWeek,
            style: TextStyle(
              color: ColorName.btnText,
              fontSize: 15,
              fontWeight: isSelect ? FontWeight.bold : null,
            ),
          ),
        ],
      ),
    );
  }
}
