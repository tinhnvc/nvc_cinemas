import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';

class RateMovieWidget extends ConsumerWidget {
  const RateMovieWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: ColorName.primary.withOpacity(0.6),
            radius: 20,
            child: Icon(
              Icons.person,
              color: ColorName.textNormal,
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Xuân Thắng  -  ★ 5',
                        style: TextStyle(
                          color: ColorName.btnText,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        '09:33 - 14/02/2023',
                        style: TextStyle(
                          color: ColorName.btnText,
                          fontSize: 15,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Phim hay, kịch bản ấn tượng. Nội dung chủ yếu tập trung vào tình cảm của Max với làng quê',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: ColorName.btnText,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
