import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:nvc_cinemas/l10n/l10n.dart';

class RoundedButtonWidget extends ConsumerWidget {
  const RoundedButtonWidget({
    required this.content,
    required this.onPressed,
    this.fontSize,
    Key? key,
  }) : super(key: key);

  final String content;
  final VoidCallback onPressed;
  final double? fontSize;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 7,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: ColorName.primary),
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(20),
            right: Radius.circular(20),
          ),
        ),
        child: Text(
          content,
          style: TextStyle(
            color: ColorName.primary,
            fontWeight: FontWeight.bold,
            fontSize: fontSize ?? 14,
          ),
        ),
      ),
    );
  }
}
