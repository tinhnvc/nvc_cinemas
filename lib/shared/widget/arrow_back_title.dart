import 'package:nvc_cinemas/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ArrowBackTitle extends ConsumerWidget {
  const ArrowBackTitle({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: onPressed,
          child: Container(
            padding: const EdgeInsets.all(10),
            child: const Icon(
              Icons.arrow_back_ios,
              size: 30,
              color: Color(0xFF3F414D),
            ),
          ),
        ),
        Expanded(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF363E59),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          child: const Icon(
            Icons.more_vert,
            size: 30,
            color: Colors.transparent,
          ),
        ),
      ],
    );
  }
}
