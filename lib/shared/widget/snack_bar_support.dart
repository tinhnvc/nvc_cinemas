import 'package:nvc_cinemas/l10n/l10n.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:nvc_cinemas/shared/util/function_ulti.dart';

class SnackBarSupport {
  static SnackBar createNotification({
    required String content,
    required int timeSecond,
    String? label,
    VoidCallback? onClicked,
  }) {
    return SnackBar(
      content: Text(content),
      duration: Duration(seconds: timeSecond),
      action: SnackBarAction(
        label: label!,
        onPressed: () {
          onClicked!();
        },
      ),
    );
  }

  static void display(BuildContext context, SnackBar snackBar) {
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void createAndDisplay({
    required BuildContext context,
    required String content,
    required int timeSecond,
    required bool hideAction,
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    final snackBar = SnackBar(
      content: Text(content),
      duration: Duration(seconds: timeSecond),
      backgroundColor: Colors.black.withOpacity(0.7),
      behavior: SnackBarBehavior.floating,
      action: hideAction
          ? SnackBarAction(
              onPressed: () {},
              label: context.l10n.ok,
            )
          : null,
    );
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void functionNotAvailableMessage({
    required BuildContext context,
    required bool hideAction,
  }) {
    final snackBar = SnackBar(
      content: Text(context.l10n.functionNotAvailable),
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.black.withOpacity(0.7),
      behavior: SnackBarBehavior.floating,
      action: hideAction
          ? SnackBarAction(
              onPressed: () {},
              label: context.l10n.ok,
            )
          : null,
    );
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void noPermission({
    required BuildContext context,
    bool? hideAction,
  }) {
    final snackBar = SnackBar(
      content: Text(context.l10n.noPermission),
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.black.withOpacity(0.7),
      behavior: SnackBarBehavior.floating,
      action: hideAction ?? false
          ? SnackBarAction(
              onPressed: () {},
              label: context.l10n.ok,
            )
          : null,
    );
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void loginFailed({
    required BuildContext context,
    bool? hideAction,
  }) {
    final snackBar = SnackBar(
      content: Text(context.l10n.loginFail),
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.black.withOpacity(0.7),
      behavior: SnackBarBehavior.floating,
      action: hideAction ?? false
          ? SnackBarAction(
              onPressed: () {},
              label: context.l10n.ok,
            )
          : null,
    );
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void signInFailed({
    required BuildContext context,
    bool? hideAction,
  }) {
    final snackBar = SnackBar(
      content: Text(context.l10n.fillAllInformation),
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.black.withOpacity(0.7),
      behavior: SnackBarBehavior.floating,
      action: hideAction ?? false
          ? SnackBarAction(
              onPressed: () {},
              label: context.l10n.ok,
            )
          : null,
    );
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void copied({
    required BuildContext context,
    bool? hideAction,
  }) {
    final snackBar = SnackBar(
      content: Text(context.l10n.copied),
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.black.withOpacity(0.7),
      behavior: SnackBarBehavior.floating,
      action: hideAction ?? false
          ? SnackBarAction(
              onPressed: () {},
              label: context.l10n.ok,
            )
          : null,
    );
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void connectivityStatus({
    required BuildContext context,
    required ConnectivityResult result,
  }) {
    var content = '';
    if (result == ConnectivityResult.none) {
      content = context.l10n.internetFail;
    }

    if (result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile) {
      content = context.l10n.internetOk;
    }

    final snackBar = SnackBar(
      content: Row(
        children: [
          Icon(
            result == ConnectivityResult.none ? Icons.wifi_off : Icons.wifi,
            size: 22,
            color: Colors.white,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            content,
          ),
        ],
      ),
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.black.withOpacity(0.7),
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    if (content.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  static void requiredSelectSeat({
    required BuildContext context,
    bool? hideAction,
  }) {
    final snackBar = SnackBar(
      content: Text(context.l10n.selectSeatYouWant),
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.black.withOpacity(0.7),
      behavior: SnackBarBehavior.floating,
      action: hideAction ?? false
          ? SnackBarAction(
              onPressed: () {},
              label: context.l10n.ok,
            )
          : null,
    );
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void avoidSelectSeat({
    required BuildContext context,
    bool? hideAction,
  }) {
    final snackBar = SnackBar(
      content: Text(context.l10n.seatNotAllowBook),
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.black.withOpacity(0.7),
      behavior: SnackBarBehavior.floating,
      action: hideAction ?? false
          ? SnackBarAction(
              onPressed: () {},
              label: context.l10n.ok,
            )
          : null,
    );
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void avoidBooking({
    required BuildContext context,
    bool? hideAction,
  }) {
    final snackBar = SnackBar(
      content: Text(context.l10n.maxNoPayTickets),
      duration: const Duration(seconds: 5),
      backgroundColor: Colors.black.withOpacity(0.7),
      behavior: SnackBarBehavior.floating,
      action: hideAction ?? false
          ? SnackBarAction(
              onPressed: () {},
              label: context.l10n.ok,
            )
          : null,
    );
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void avoidFunction({
    required BuildContext context,
    bool? hideAction,
  }) {
    final snackBar = SnackBar(
      content: Text('Không thể thực hiện thao tác'),
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.black.withOpacity(0.7),
      behavior: SnackBarBehavior.floating,
      action: hideAction ?? false
          ? SnackBarAction(
              onPressed: () {},
              label: context.l10n.ok,
            )
          : null,
    );
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void noRoomToAddShowtime({
    required BuildContext context,
    bool? hideAction,
  }) {
    final snackBar = SnackBar(
      content: Text('Không có phòng, thêm phòng trước khi thực hiện thao tác'),
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.black.withOpacity(0.7),
      behavior: SnackBarBehavior.floating,
      action: hideAction ?? false
          ? SnackBarAction(
              onPressed: () {},
              label: context.l10n.ok,
            )
          : null,
    );
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void avoidBookWithAge({
    required BuildContext context,
    required String movieType,
    bool? hideAction,
  }) {
    final customerObj = FunctionUtil.ageToTitle(context, movieType);
    final snackBar = SnackBar(
      content: Text(
          'Phim dành cho ${customerObj.toLowerCase()}\nKhách hàng vui lòng lựa chọn phim khác. Xin cảm ơn!'),
      duration: const Duration(seconds: 4),
      backgroundColor: Colors.black.withOpacity(0.7),
      behavior: SnackBarBehavior.floating,
      action: hideAction ?? false
          ? SnackBarAction(
              onPressed: () {},
              label: context.l10n.ok,
            )
          : null,
    );
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void accountBaned({
    required BuildContext context,
    bool? hideAction,
  }) {
    final snackBar = SnackBar(
      content: Text(
          'Tài khoản của quý khách đã bị khoá.\nLiên hệ bộ phận CSKH để được hỗ trợ.'),
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.black.withOpacity(0.7),
      behavior: SnackBarBehavior.floating,
      action: hideAction ?? false
          ? SnackBarAction(
              onPressed: () {},
              label: context.l10n.ok,
            )
          : null,
    );
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void avoidAddShowTimeBeforeReleaseDate({
    required BuildContext context,
    bool? hideAction,
  }) {
    final snackBar = SnackBar(
      content: Text(
          'Ngày đang chọn phim chưa phát hành, chọn ngày khác để thêm lịch chiếu'),
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.black.withOpacity(0.7),
      behavior: SnackBarBehavior.floating,
      action: hideAction ?? false
          ? SnackBarAction(
              onPressed: () {},
              label: context.l10n.ok,
            )
          : null,
    );
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
