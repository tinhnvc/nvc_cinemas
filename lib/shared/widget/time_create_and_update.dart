import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/l10n/l10n.dart';
import 'package:nvc_cinemas/shared/util/format_support.dart';

class TimeCrateAndUpdate extends ConsumerWidget {
  const TimeCrateAndUpdate({
    required this.createTime,
    required this.updateTime,
    Key? key,
  }) : super(key: key);
  final int createTime;
  final int updateTime;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  context.l10n.createTime,
                  style: const TextStyle(
                    color: Color(0xFF363E59),
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                Text(
                  FormatSupport.toDateTimeNonSecond(createTime),
                  style: const TextStyle(
                    color: Color(0xFF363E59),
                    fontStyle: FontStyle.italic,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  context.l10n.updateLastTime,
                  style: const TextStyle(
                    color: Color(0xFF363E59),
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                Text(
                  FormatSupport.toDateTimeNonSecond(updateTime),
                  style: const TextStyle(
                    color: Color(0xFF363E59),
                    fontStyle: FontStyle.italic,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
