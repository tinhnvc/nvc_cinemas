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
              color: Colors.white,
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
                color: Colors.white,
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

  static void alertPopUpCreated({
    required VoidCallback onPressedConfirm,
  }) {
    final context = OneContext().context;
    Alert(
      context: context!,
      type: AlertType.success,
      title: '${context.l10n.addNew} ${context.l10n.success}',
      desc: null,
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
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ],
    ).show();
  }

  static void alertPopUpUpdated({
    required VoidCallback onPressedConfirm,
  }) {
    final context = OneContext().context;
    Alert(
      context: context!,
      type: AlertType.success,
      title: '${context.l10n.updated} ${context.l10n.success}',
      desc: null,
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
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ],
    ).show();
  }

  static void alertPopUpPayed({
    required VoidCallback onPressedConfirm,
  }) {
    final context = OneContext().context;
    Alert(
      context: context!,
      type: AlertType.success,
      title: '${context.l10n.success}',
      closeFunction: () {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/home-page',
          (Route<dynamic> route) => false,
        );
      },
      desc:
          'Đặt vé thành công!\nKiểm tra thông tin và trạng thái tại mục vé. Xin cảm ơn!',
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
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ],
    ).show();
  }

  static String couponCodeToContent(
    BuildContext context,
    String couponCode,
  ) {
    final map = {
      'COU10': '${context.l10n.discountTicket} 10.000đ',
      'COU15': '${context.l10n.discountTicket} 15.000đ',
      'COU20': '${context.l10n.discountTicket} 20.000đ',
      'COU30': '${context.l10n.discountTicket} 30.000đ',
      'DANGO45': '${context.l10n.dangoTicket} 45.000đ',
      'DANGO55': '${context.l10n.dangoTicket} 55.000đ',
      'DANGO65': '${context.l10n.dangoTicket} 65.000đ',
      'DANGO75': '${context.l10n.dangoTicket} 75.000đ',
    };

    return map[couponCode] ?? '';
  }

  static String couponCodeToDiscount(
    BuildContext context,
    String couponCode,
    String currentPrice,
  ) {
    final price = int.parse(currentPrice);
    final map = {
      'COU10': '10000',
      'COU15': '15000',
      'COU20': '20000',
      'COU30': '30000',
      'DANGO45': price > 45000 ? '${price - 45000}' : '0',
      'DANGO55': price > 55000 ? '${price - 55000}' : '0',
      'DANGO65': price > 65000 ? '${price - 65000}' : '0',
      'DANGO75': price > 70000 ? '${price - 75000}' : '0',
    };

    return map[couponCode] ?? '';
  }

  static String ticketStatusToContent(
    BuildContext context,
    String status,
  ) {
    final map = {
      'waitPay': 'Chờ thanh toán',
      'waitConfirm': 'Chờ xác nhận',
      'payed': 'Đã thanh toán',
      'canceled': 'Đã huỷ',
    };

    return map[status] ?? 'Chờ thanh toán';
  }

  static String couponCodeToTotalPrice(
    BuildContext context,
    String couponCode,
    String currentPrice,
  ) {
    final price = int.parse(currentPrice);
    final map = {
      'COU10': '${price - 10000}',
      'COU15': '${price - 15000}',
      'COU20': '${price - 20000}',
      'COU30': '${price - 30000}',
      'DANGO45': '45000',
      'DANGO55': '55000',
      'DANGO65': '65000',
      'DANGO75': '75000',
    };

    return map[couponCode] ?? '';
  }

  static Color ticketStatusToColor(
    String status,
  ) {
    if (status == 'waitPay') {
      return Colors.red;
    }

    if (status == 'waitConfirm') {
      return Colors.orange;
    }

    if (status == 'payed') {
      return Colors.green;
    }

    if (status == 'canceled') {
      return ColorName.primary;
    }
    return Colors.grey;
  }

  static Color roleTitleToColor(
    String roleTitle,
  ) {
    if (roleTitle == 'Quản trị viên') {
      return Colors.green;
    }

    if (roleTitle == 'Nhân viên') {
      return Colors.blue.withOpacity(0.5);
    }

    if (roleTitle == 'Khách hàng') {
      return ColorName.primary;
    }

    return ColorName.primary;
  }

  static void alertPopUpConfirmWithContent({
    required VoidCallback onPressedConfirm,
    required String content,
    bool? isConfirm = false,
  }) {
    final context = OneContext().context;
    Alert(
      context: context!,
      type: AlertType.warning,
      title: 'Lưu ý',
      desc: 'Đồng ý thực hiện đóng $content',
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
              color: Colors.white,
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
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
      ],
    ).show();
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
