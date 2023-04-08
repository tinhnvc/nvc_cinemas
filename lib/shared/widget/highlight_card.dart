import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';

class HighlightCard extends ConsumerWidget {
  const HighlightCard({
    required this.widget,
    required this.padding,
    Key? key,
  }) : super(key: key);
  final Widget widget;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: ColorName.primary.withOpacity(0.3),
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(6),
          right: Radius.circular(6),
        ),
      ),
      child: widget,
    );
  }
}
