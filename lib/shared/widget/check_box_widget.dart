import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:flutter/material.dart';

class CheckBoxWidget extends StatelessWidget {
  const CheckBoxWidget({
    Key? key,
    required this.isChecked,
    required this.onPressed,
    this.isActive,
  }) : super(key: key);

  final bool isChecked;
  final bool? isActive;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isActive ?? true ? onPressed : null,
      child: isActive ?? true
          ? AnimatedContainer(
              duration: const Duration(
                milliseconds: 500,
              ),
              curve: Curves.bounceIn,
              width: 19,
              height: 19,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: Colors.grey,
                ),
                color: isChecked ? ColorName.primary : Colors.white,
              ),
              child: isChecked
                  ? const Icon(
                      Icons.done_sharp,
                      color: Colors.white,
                      size: 16,
                    )
                  : null,
            )
          : AnimatedContainer(
              duration: const Duration(
                milliseconds: 500,
              ),
              curve: Curves.bounceIn,
              width: 19,
              height: 19,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: Colors.grey,
                ),
                color: ColorName.primary,
              ),
              child: const Icon(
                Icons.done_sharp,
                color: Colors.white,
                size: 16,
              ),
            ),
    );
  }
}
