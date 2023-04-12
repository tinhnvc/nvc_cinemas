import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/gen/assets.gen.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:nvc_cinemas/l10n/l10n.dart';

class MMovieItem extends ConsumerWidget {
  const MMovieItem({Key? key}) : super(key: key);

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150,
            width: 100,
            margin: const EdgeInsets.only(right: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(6)),
            ),
            child: Assets.images.logoPng.image(width: 100, fit: BoxFit.contain),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: width * 0.3,
                      child: Text(
                        'Ngôi làng của lá và sự trở lại của Mask mark mark mark',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 17,
                          color: ColorName.textNormal,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () =>
                              Navigator.pushNamed(context, '/add-showtimes'),
                          child: Icon(
                            Icons.date_range_rounded,
                            size: 25,
                            color: ColorName.primary,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () =>
                              Navigator.pushNamed(context, '/edit-movie'),
                          child: Icon(
                            Icons.edit_note,
                            size: 25,
                            color: ColorName.primary,
                          ),
                        ),
                        Transform.scale(
                          scale: 0.7,
                          alignment: Alignment.topCenter,
                          child: CupertinoSwitch(
                            value: true,
                            onChanged: (bool value) {},
                            activeColor: ColorName.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Tâm lý, hành động | 95 phút',
                  style: TextStyle(
                    fontSize: 15,
                    color: ColorName.textNormal,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  '${context.l10n.releaseShow}: 14/03/2023',
                  style: TextStyle(
                    fontSize: 15,
                    color: ColorName.textNormal,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  '${context.l10n.createAt}: 11:02 - 13/02/2023',
                  style: TextStyle(
                    fontSize: 15,
                    color: ColorName.textNormal,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
