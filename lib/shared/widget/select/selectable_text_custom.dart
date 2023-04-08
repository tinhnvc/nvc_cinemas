import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectableTextCustom extends ConsumerWidget {
  const SelectableTextCustom({
    required this.text,
    required this.style,
    this.maxLines,
    this.textAlign,
    this.selectionColor,
    Key? key,
  }) : super(key: key);
  final String text;
  final TextStyle style;
  final int? maxLines;
  final TextAlign? textAlign;
  final Color? selectionColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextSelectionTheme(
      data: TextSelectionThemeData(
        cursorColor: ColorName.primary,
        selectionColor: selectionColor ?? ColorName.primary.withOpacity(0.4),
      ),
      child: SelectableText(
        text,
        maxLines: maxLines,
        style: style,
        textAlign: textAlign,
        cursorRadius: const Radius.circular(15),
        toolbarOptions: const ToolbarOptions(copy: true, selectAll: true),
      ),
    );
  }
}
