import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DropdownWidget extends ConsumerWidget {
  const DropdownWidget({
    Key? key,
    required this.value,
    required this.values,
    required this.onChanged,
  }) : super(key: key);
  final String value;
  final List<String> values;
  final Function onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    final inset = MediaQuery.of(context).viewInsets;
    final height = size.height - (padding.top + padding.bottom + inset.bottom);
    final width = size.width - (padding.left + padding.right + inset.right);
    final ratio = height / size.width;

    return DropdownButton(
      menuMaxHeight: height * 0.35,
      value: value,
      items: values
          .map<DropdownMenuItem<String>>(
            (e) => DropdownMenuItem(
              value: e,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: width * 0.45,
                    child: Text(
                      e,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 14,
                        color: e == value
                            ? ColorName.primary
                            : const Color(0xFF4B5574),
                        fontWeight: e == value ? FontWeight.w600 : null,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  if (e == value)
                    const Icon(
                      Icons.done,
                      size: 22,
                      color: Color(0xFF27AE60),
                    )
                  else
                    Container(),
                ],
              ),
            ),
          )
          .toList(),
      isExpanded: true,
      icon: const Icon(
        Icons.keyboard_arrow_down,
        size: 22,
        color: Color(0xFF363E59),
      ),
      underline: Container(
        height: 1,
        color: const Color(0xFFB4B9C8),
      ),
      selectedItemBuilder: (context) => values
          .map<DropdownMenuItem<String>>(
            (e) => DropdownMenuItem(
              value: e,
              child: Text(
                e,
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF4B5574),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          )
          .toList(),
      onChanged: (value) => onChanged(value),
    );
  }
}
