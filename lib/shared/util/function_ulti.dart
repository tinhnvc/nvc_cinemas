import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:nvc_cinemas/l10n/l10n.dart';
import 'package:nvc_cinemas/shared/provider/util_provider.dart';
import 'package:nvc_cinemas/shared/repository/language_repository.dart';
import 'package:one_context/one_context.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class FunctionUtil {
  // ignore: long-parameter-list
  static void alertPopUpConfirm({
    required VoidCallback onPressedConfirm,
    required AlertType type,
    required String title,
    required String desc,
    bool? isConfirm = false,
  }) {
    final context = OneContext().context;
    Alert(
      context: context!,
      type: type,
      title: title,
      desc: desc.isNotEmpty ? desc : null,
      style: const AlertStyle(
        titleStyle: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
        descStyle: TextStyle(
          fontSize: 15,
        ),
      ),
      buttons: [
        DialogButton(
          color: ColorName.primary,
          radius: const BorderRadius.all(Radius.circular(5)),
          height: 44,
          onPressed: () {
            onPressedConfirm();
            Navigator.pop(context);
          },
          child: const Text(
            'OK',
            style: TextStyle(
              color: ColorName.btnText,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
        if (!isConfirm!)
          DialogButton(
            color: const Color(0xFFAAAAAA),
            radius: const BorderRadius.all(Radius.circular(5)),
            height: 44,
            onPressed: () => Navigator.pop(context),
            child: Text(
              context.l10n.cancel,
              style: const TextStyle(
                color: ColorName.btnText,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
      ],
    ).show();
  }

  static String genderSelectToFormValue(BuildContext context, String gender) {
    final map = {
      context.l10n.unknown: 'unknown',
      context.l10n.male: 'male',
      context.l10n.female: 'female',
    };

    return map[gender] ?? 'unknown';
  }

  static Future<void> changeLanguageApp(WidgetRef ref, String language) async {
    await ref.read(languageRepositoryProvider).saveLanguage(language);
    ref.read(languageProvider.notifier).update(language);
  }
}
//
// class URLUlti {
//   static Future<void> launchURL({
//     required String url,
//   }) async {
//     final uri = Uri.parse(url);
//     if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
//       throw 'Can not launch url';
//     }
//   }
// }
//
// class DateTimeUlti {
//   static int getEndTimeToDay() {
//     final now = DateTime.now();
//     final nowNonHour = DateTime(now.year, now.month, now.day + 1);
//
//     return nowNonHour.millisecondsSinceEpoch - 1;
//   }
//
//   static int getStartTimeToDay() {
//     final now = DateTime.now();
//     final nowNonHour = DateTime(now.year, now.month, now.day);
//
//     return nowNonHour.millisecondsSinceEpoch;
//   }
//
//   static int getTimeAMonthAgo() {
//     final now = DateTime.now();
//     final nowNonHour = DateTime(now.year, now.month, now.day + 1);
//     final monthAgo = nowNonHour.subtract(const Duration(days: 30));
//
//     return monthAgo.millisecondsSinceEpoch;
//   }
//
//   static bool overTime() {
//     final now = DateTime.now();
//     final hours = now.hour;
//     print(hours);
//
//     return hours < 8 || hours >= 17;
//   }
// }
