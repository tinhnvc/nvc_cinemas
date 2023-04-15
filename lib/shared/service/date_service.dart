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
        'day': today,
        'dayOfWeek': context.l10n.today,
      },
      {
        'day': second,
        'dayOfWeek': isVietnamese
            ? DateFormat('EE', 'vi').format(second)
            : DateFormat('EE').format(second),
      },
      {
        'day': third,
        'dayOfWeek': isVietnamese
            ? DateFormat('EE', 'vi').format(third)
            : DateFormat('EE').format(third),
      },
      {
        'day': fourth,
        'dayOfWeek': isVietnamese
            ? DateFormat('EE', 'vi').format(fourth)
            : DateFormat('EE').format(fourth),
      },
      {
        'day': fifth,
        'dayOfWeek': isVietnamese
            ? DateFormat('EE', 'vi').format(fifth)
            : DateFormat('EE').format(fifth),
      },
      {
        'day': sixth,
        'dayOfWeek': isVietnamese
            ? DateFormat('EE', 'vi').format(sixth)
            : DateFormat('EE').format(sixth),
      },
      {
        'day': seventh,
        'dayOfWeek': isVietnamese
            ? DateFormat('EE', 'vi').format(seventh)
            : DateFormat('EE').format(seventh),
      },
    ];

    return weekMap;
  }
}
