import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/gen/assets.gen.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:nvc_cinemas/l10n/l10n.dart';
import 'package:nvc_cinemas/shared/link/assets.dart';
import 'package:nvc_cinemas/shared/widget/primary_button_widget.dart';
import 'package:nvc_cinemas/shared/widget/rounded_button_widget.dart';
import 'package:nvc_cinemas/shared/widget/select/selectable_text_custom.dart';
import 'package:nvc_cinemas/shared/widget/snack_bar_support.dart';

class PaymentQrModalSheet extends ConsumerWidget {
  const PaymentQrModalSheet({Key? key}) : super(key: key);

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
                      context.l10n.pay,
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Assets.images.paymentQr
                                    .image(width: 250, fit: BoxFit.cover),
                              ],
                            ),
                            SelectableTextCustom(
                              text:
                                  '${context.l10n.content}: tt 4b9217d3-a1fd-4b8e-bc2b-0580e863d1da',
                              style: TextStyle(
                                color: ColorName.btnText,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              bankInformation[0],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: ColorName.btnText,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SelectableTextCustom(
                              text: bankInformation[1],
                              style: TextStyle(
                                color: ColorName.btnText,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RoundedButtonWidget(
                                  content: context.l10n.copyContent,
                                  onPressed: () async {
                                    await FlutterClipboard.copy(
                                      'tt 4b9217d3-a1fd-4b8e-bc2b-0580e863d1da',
                                    );
                                    SnackBarSupport.copied(context: context);
                                  },
                                ),
                                RoundedButtonWidget(
                                  content: context.l10n.copyBank,
                                  onPressed: () async {
                                    await FlutterClipboard.copy(
                                      bankInformation[1],
                                    );
                                    SnackBarSupport.copied(context: context);
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            PrimaryButtonWidget(
                              content: context.l10n.payOk,
                              width: 250,
                              onPressed: () {},
                            ),
                            const SizedBox(
                              height: 15,
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
