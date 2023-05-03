import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/feature/payment/provider/payment_provider.dart';
import 'package:nvc_cinemas/feature/ticket/model/ticket_model.dart';
import 'package:nvc_cinemas/feature/ticket/provider/ticket_provider.dart';
import 'package:nvc_cinemas/gen/assets.gen.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:nvc_cinemas/l10n/l10n.dart';
import 'package:nvc_cinemas/shared/link/assets.dart';
import 'package:nvc_cinemas/shared/widget/rounded_button_widget.dart';
import 'package:nvc_cinemas/shared/widget/select/selectable_text_custom.dart';
import 'package:nvc_cinemas/shared/widget/snack_bar_support.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class TicketQrModalSheet extends ConsumerWidget {
  const TicketQrModalSheet({required this.ticketId, Key? key})
      : super(key: key);
  final String ticketId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Stack(
            children: [
              Container(
                height: 50,
                padding: const EdgeInsets.only(
                  left: 25,
                  // top: 10,
                  // bottom: 10,
                  right: 5,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Mã QR',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Color(0xFF363E59),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 50),
                child: const Divider(
                  height: 3,
                  color: ColorName.textNormal,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 60),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 25,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(7),
                              margin: const EdgeInsets.symmetric(vertical: 7),
                              decoration: BoxDecoration(
                                border: Border.all(color: ColorName.primary),
                                borderRadius: BorderRadius.horizontal(
                                  left: Radius.circular(20),
                                  right: Radius.circular(20),
                                ),
                              ),
                              child: QrImage(
                                data: ticketId,
                                size: 200,
                                backgroundColor: Colors.white,
                              ),
                            ),
                            Text(
                              'Khách hàng sử dụng mã QR này để nhận vé tại rạp.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 17,
                                color: ColorName.textNormal,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'Lưu ý: Không cung cấp mã QR này cho bất kỳ ai ngoại trừ nhân viên tại quầy vé.\nXin cảm ơn!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.red,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
