import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:nvc_cinemas/l10n/l10n.dart';
import 'package:nvc_cinemas/shared/widget/call_modal_sheet.dart';

class MShowtimesItem extends ConsumerWidget {
  const MShowtimesItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                    '11:20',
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
                    'P04',
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
                    '30 ${context.l10n.seat.toLowerCase()}s',
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
                    '${context.l10n.endTime}: 13:10 - 13/02/2023',
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
