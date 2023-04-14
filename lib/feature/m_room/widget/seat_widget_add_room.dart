import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:nvc_cinemas/l10n/l10n.dart';

class SeatWidgetAddRoom extends ConsumerWidget {
  const SeatWidgetAddRoom({
    required this.color,
    required this.isNormal,
    Key? key,
  }) : super(key: key);

  final Color color;
  final bool isNormal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final seatTypes = [context.l10n.normalSeat, context.l10n.vipSeat];

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
                  width: 27,
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
