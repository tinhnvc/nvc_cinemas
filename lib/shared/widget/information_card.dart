import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';

class InformationCard extends ConsumerWidget {
  const InformationCard({
    required this.content,
    required this.onPressed,
    Key? key,
  }) : super(key: key);
  final String content;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: ColorName.primary,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Text(
          content,
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
