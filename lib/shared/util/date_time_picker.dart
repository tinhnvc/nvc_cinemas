import 'package:flutter/material.dart';
import 'package:month_year_picker/month_year_picker.dart';

class DateTimePicker {
  static Future<DateTime> pickDateTime(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 3),
      lastDate: DateTime(DateTime.now().year + 3),
    );
    if (date == null) {
      return DateTime.now();
    }
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time == null) {
      return DateTime.now();
    }
    final dateTime =
        DateTime(date.year, date.month, date.day, time.hour, time.minute);

    return dateTime;
  }

  static Future<DateTime> pickDate(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 3),
      lastDate: DateTime(DateTime.now().year + 3),
    );
    if (date == null) {
      return DateTime.now();
    }
    final dateTime = DateTime(date.year, date.month, date.day);

    return dateTime;
  }

  static Future<DateTime> pickDateInit({
    required BuildContext context,
    required int initDate,
  }) async {
    final initDateTime = initDate != 0
        ? DateTime.fromMillisecondsSinceEpoch(initDate)
        : DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: initDateTime,
      firstDate: DateTime(1900),
      lastDate: DateTime(DateTime.now().year + 10),
    );
    if (date == null) {
      return initDateTime;
    }
    final dateTime = DateTime(date.year, date.month, date.day);

    return dateTime;
  }

  static Future<DateTime> pickDateTimeInit({
    required BuildContext context,
    required int initDate,
  }) async {
    final initDateTime = initDate != 0
        ? DateTime.fromMillisecondsSinceEpoch(initDate)
        : DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: initDateTime,
      firstDate: DateTime(1900),
      lastDate: DateTime(DateTime.now().year + 10),
    );
    if (date == null) {
      return DateTime.now();
    }
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time == null) {
      return DateTime.now();
    }
    final dateTime =
        DateTime(date.year, date.month, date.day, time.hour, time.minute);

    return dateTime;
  }

  static Future<DateTime> pickMonth(BuildContext context) async {
    final date = await showMonthYearPicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      locale: const Locale('vi'),
    );
    if (date == null) {
      return DateTime.now();
    }
    final dateTime = DateTime(date.year, date.month, 1);

    return dateTime;
  }

  static Future<DateTimeRange> pickDateRange({
    required BuildContext context,
    required int start,
    required int end,
  }) async {
    DateTime startTime;
    DateTime endTime;
    if (start != 0 && end != 0) {
      startTime = DateTime.fromMillisecondsSinceEpoch(start);
      endTime = DateTime.fromMillisecondsSinceEpoch(end);
    } else {
      startTime = DateTime.now();
      endTime = DateTime.now();
    }

    final initialDateRange = DateTimeRange(
      start: startTime,
      end: endTime,
    );

    final newDateRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDateRange: initialDateRange,
    );
    if (newDateRange == null) {
      return DateTimeRange(start: startTime, end: endTime);
    }

    return newDateRange;
  }
}
