import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:nvc_cinemas/l10n/l10n.dart';
import 'package:nvc_cinemas/shared/util/function_ulti.dart';
import 'package:nvc_cinemas/shared/widget/call_modal_sheet.dart';
import 'package:nvc_cinemas/shared/widget/rounded_button_widget.dart';
import 'package:nvc_cinemas/shared/widget/select/selectable_text_custom.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class TicketItem extends ConsumerWidget {
  const TicketItem({required this.isPayed, Key? key}) : super(key: key);
  final bool isPayed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    final inset = MediaQuery.of(context).viewInsets;
    final height = size.height - (padding.top + padding.bottom + inset.bottom);
    final width = size.width - (padding.left + padding.right + inset.right);
    final ratio = height / size.width;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: [
          rowInformation(
            title: 'Mã vé',
            content: 'c6f355df-d0e4-4825-a542-bae6330a6f7f',
            width: width,
            isSelectable: true,
          ),
          rowInformation(
            title: context.l10n.film,
            content: 'Ngôi làng của lá',
            width: width,
          ),
          rowInformation(
            title: context.l10n.dateShow,
            content: '13/02/2023',
            width: width,
          ),
          rowInformation(
            title: context.l10n.timeShow,
            content: '11:20',
            width: width,
          ),
          rowInformation(
            title: context.l10n.roomShow,
            content: 'P4',
            width: width,
          ),
          rowInformation(
            title: context.l10n.seat,
            content: 'D7',
            width: width,
          ),
          rowInformation(
            title: context.l10n.createAt,
            content: '10:22 - 12/02/2023',
            width: width,
          ),
          rowStatusTicket(
            context: context,
            status: isPayed ? context.l10n.payed : context.l10n.noPay,
            width: width,
          ),
          rowInformation(
            title: context.l10n.pay,
            content: '60.000đ',
            width: width,
            isSpecial: true,
          ),
          if (!isPayed)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RoundedButtonWidget(
                    content: context.l10n.pay,
                    onPressed: () =>
                        CallModalSheet.showPaymentQrModalSheet(context),
                  ),
                  RoundedButtonWidget(
                    content: context.l10n.cancel,
                    onPressed: () {
                      FunctionUtil.alertPopUpConfirm(
                        onPressedConfirm: () {},
                        type: AlertType.warning,
                        title: 'Huỷ vé',
                        desc: 'Xác nhận huỷ đặt vé?',
                      );
                    },
                  )
                ],
              ),
            )
        ],
      ),
    );
  }

  Widget rowInformation({
    required String title,
    required String content,
    required double width,
    bool? isSpecial,
    bool? isSelectable,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: width * 0.3,
            child: Text(
              title,
              style: TextStyle(
                overflow: TextOverflow.clip,
                fontSize: 15,
                color: ColorName.textNormal,
                fontWeight: isSpecial ?? false ? FontWeight.w600 : null,
              ),
            ),
          ),
          Expanded(
            child: isSelectable ?? false
                ? SelectableTextCustom(
                    text: content,
                    style: TextStyle(
                      overflow: TextOverflow.clip,
                      fontSize: 15,
                      color: ColorName.textNormal,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                : Text(
                    content,
                    style: TextStyle(
                      overflow: TextOverflow.clip,
                      fontSize: 15,
                      color: ColorName.textNormal,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget rowStatusTicket({
    required BuildContext context,
    required String status,
    required double width,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: width * 0.3,
            child: Text(
              context.l10n.status,
              style: TextStyle(
                overflow: TextOverflow.clip,
                fontSize: 15,
                color: ColorName.textNormal,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: status == context.l10n.payed ? Colors.green : Colors.red,
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(15),
                right: Radius.circular(15),
              ),
            ),
            child: Text(
              status,
              style: TextStyle(
                overflow: TextOverflow.clip,
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
