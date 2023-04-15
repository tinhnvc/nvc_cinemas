import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class PrimaryButtonWidget extends ConsumerWidget {
  const PrimaryButtonWidget({
    required this.content,
    required this.width,
    required this.onPressed,
    this.active,
    Key? key,
  }) : super(key: key);
  final String content;
  final double width;
  final VoidCallback onPressed;
  final bool? active;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DialogButton(
      color: active ?? false
          ? ColorName.primary
          : ColorName.primary.withOpacity(0.5),
      radius: const BorderRadius.all(Radius.circular(5)),
      height: 40,
      width: width,
      onPressed: onPressed,
      child: Text(
        content,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
    );
  }
}
