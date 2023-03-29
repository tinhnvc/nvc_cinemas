import 'package:nvc_cinemas/l10n/l10n.dart';
import 'package:flutter/material.dart';

class ConstantsUlti {
  static Map<String, String> oppAssignTypeMap(BuildContext context) {
    final map = {
      context.l10n.cancel: 'cancel',
      context.l10n.password: 'password',
      context.l10n.your_email: 'email',
    };

    return map;
  }

  static String oppAssignTypeToValueForm(
    BuildContext context,
    String oppAssignType,
  ) {
    final map = oppAssignTypeMap(context);

    return map[oppAssignType].toString();
  }

  static String oppAssignTypeToKeyMap(
    BuildContext context,
    String oppAssignType,
  ) {
    final map = oppAssignTypeMap(context);

    return map.keys.firstWhere(
      (key) => map[key].toString() == oppAssignType,
      orElse: () => context.l10n.cancel,
    );
  }
}
