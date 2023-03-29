import 'package:diacritic/diacritic.dart';
import 'package:intl/intl.dart';

class FormatSupport {
  static final NumberFormat _oCcy = NumberFormat('#,##0', 'en_US');
  static final DateFormat _dateFormat = DateFormat('dd/MM/yyyy HH:mm:ss');
  static final DateFormat _dateFormatNonSecond = DateFormat('dd/MM/yyyy HH:mm');
  static final DateFormat _dateFormatNonHour = DateFormat('dd/MM/yyyy');
  static final DateFormat _dateFormatMonthYear = DateFormat('MM/yyyy');
  static final DateFormat _dateFormatNonDate = DateFormat('HH:mm');

  static String toMoney(int value) {
    return _oCcy.format(value);
  }

  static String toDateTime(int value) {
    final timeConvert = DateTime.fromMillisecondsSinceEpoch(value);
    final result = _dateFormat.format(timeConvert);

    return result;
  }

  static String toDateTimeNonSecond(int value) {
    final timeConvert = DateTime.fromMillisecondsSinceEpoch(value);
    final result = _dateFormatNonSecond.format(timeConvert);

    return result;
  }

  static String toDateTimeNonHour(int value) {
    final timeConvert = DateTime.fromMillisecondsSinceEpoch(value);
    final result = _dateFormatNonHour.format(timeConvert);

    return result;
  }

  static String toDateTimeNonDate(int value) {
    final timeConvert = DateTime.fromMillisecondsSinceEpoch(value);
    final result = _dateFormatNonDate.format(timeConvert);

    return result;
  }

  static String toDateTimeMonthYear(int value) {
    final timeConvert = DateTime.fromMillisecondsSinceEpoch(value);
    final result = _dateFormatMonthYear.format(timeConvert);

    return result;
  }

  static String formatDate(DateTime dateTime) {
    return _dateFormat.format(dateTime);
  }

  static String formatDateNonSecond(DateTime dateTime) {
    return _dateFormatNonSecond.format(dateTime);
  }

  static String secondToHour(int second) {
    final duration = Duration(seconds: second);

    return duration.toString().split('.').first.padLeft(8, '0');
  }

  static bool isNumeric(String str) {
    if (str.isEmpty) {
      return false;
    }
    if (str.contains('-')) {
      return false;
    }

    return int.tryParse(str) != null;
  }

  static String generateFieldKey(String str) {
    final removeDiacriticString = removeDiacritics(str);
    final list = removeDiacriticString.split(' ')
      ..removeWhere((element) => element == ' ' || element.isEmpty);
    final result = list.join('-').toLowerCase();

    return result;
  }
}
