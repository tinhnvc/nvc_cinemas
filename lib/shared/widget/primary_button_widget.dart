import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class PrimaryButtonWidget extends ConsumerWidget {
  const PrimaryButtonWidget({
    required this.content,
    required this.width,
    required this.onPressed,
    Key? key,
  }) : super(key: key);
  final String content;
  final double width;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DialogButton(
      color: ColorName.primary,
      radius: const BorderRadius.all(Radius.circular(5)),
      height: 40,
      width: width,
      onPressed: onPressed,
      child: Text(
        content,
        style: const TextStyle(
          color: ColorName.btnText,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
    );
  }
}
