import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:nvc_cinemas/l10n/l10n.dart';
import 'package:nvc_cinemas/shared/provider/util_provider.dart';
import 'package:path/path.dart';

class DateService {
  static List<Map<String, dynamic>> dateRangeInWeek(
      WidgetRef ref, BuildContext context) {
    final isVietnamese = ref.watch(languageProvider) == 'vi';
    final timeNow = DateTime.now();
    final year = timeNow.year;
    final month = timeNow.month;
    final day = timeNow.day;

    final today = DateTime(year, month, day);
    final second = today.add(const Duration(days: 1));
    final third = second.add(const Duration(days: 1));
    final fourth = third.add(const Duration(days: 1));
    final fifth = fourth.add(const Duration(days: 1));
    final sixth = fifth.add(const Duration(days: 1));
    final seventh = sixth.add(const Duration(days: 1));

    final weekMap = [
      {
        'id': 'c1d8b61c-fc54-4ec9-a9af-16ce093c93a1',
        'day': today.millisecondsSinceEpoch,
        'dayOfWeek': context.l10n.today,
      },
      {
        'id': 'bb0340a2-8785-4bf1-b5c4-9a985f372630',
        'day': second.millisecondsSinceEpoch,
        'dayOfWeek': isVietnamese
            ? DateFormat('EE', 'vi').format(second)
            : DateFormat('EE').format(second),
      },
      {
        'id': 'add40aa1-bac9-435e-b556-3bc0f02b6a05',
        'day': third.millisecondsSinceEpoch,
        'dayOfWeek': isVietnamese
            ? DateFormat('EE', 'vi').format(third)
            : DateFormat('EE').format(third),
      },
      {
        'id': '6b43ae31-a32d-44f1-a850-1beb0f936a35',
        'day': fourth.millisecondsSinceEpoch,
        'dayOfWeek': isVietnamese
            ? DateFormat('EE', 'vi').format(fourth)
            : DateFormat('EE').format(fourth),
      },
      {
        'id': '12646fc7-f71f-4a8c-9500-eebdb85b82a3',
        'day': fifth.millisecondsSinceEpoch,
        'dayOfWeek': isVietnamese
            ? DateFormat('EE', 'vi').format(fifth)
            : DateFormat('EE').format(fifth),
      },
      {
        'id': '89427616-088b-4320-a5c8-c267aa2b4a30',
        'day': sixth.millisecondsSinceEpoch,
        'dayOfWeek': isVietnamese
            ? DateFormat('EE', 'vi').format(sixth)
            : DateFormat('EE').format(sixth),
      },
      {
        'id': '2edfd335-056f-42d6-85a7-26f909fa8bd9',
        'day': seventh.millisecondsSinceEpoch,
        'dayOfWeek': isVietnamese
            ? DateFormat('EE', 'vi').format(seventh)
            : DateFormat('EE').format(seventh),
      },
    ];

    return weekMap;
  }
}
