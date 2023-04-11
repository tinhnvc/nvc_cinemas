import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';

class CategoryItem extends ConsumerWidget {
  const CategoryItem({
    required this.title,
    required this.active,
    Key? key,
  }) : super(key: key);

  final String title;
  final bool active;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    final inset = MediaQuery.of(context).viewInsets;
    final height = size.height - (padding.top + padding.bottom + inset.bottom);
    final width = size.width - (padding.left + padding.right + inset.right);
    final ratio = height / size.width;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: ColorName.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: width * 0.6,
            child: Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: ColorName.btnText,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/edit-category'),
                child: Icon(
                  Icons.edit_note,
                  size: 25,
                  color: ColorName.btnText,
                ),
              ),
              Transform.scale(
                scale: 0.7,
                child: CupertinoSwitch(
                  value: active,
                  onChanged: (bool value) {},
                  activeColor: ColorName.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
