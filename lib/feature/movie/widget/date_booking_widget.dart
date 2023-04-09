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
    return Container(
      margin: const EdgeInsets.only(right: 25),
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
