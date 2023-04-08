import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/feature/movie/widget/date_booking_widget.dart';
import 'package:nvc_cinemas/feature/movie/widget/rate_movie_widget.dart';
import 'package:nvc_cinemas/feature/movie/widget/time_booking_widget.dart';
import 'package:nvc_cinemas/gen/assets.gen.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:nvc_cinemas/l10n/l10n.dart';
import 'package:nvc_cinemas/shared/widget/arrow_back_title.dart';
import 'package:nvc_cinemas/shared/widget/highlight_card.dart';
import 'package:nvc_cinemas/shared/widget/primary_button_widget.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class MovieDetail extends ConsumerWidget {
  const MovieDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    final inset = MediaQuery.of(context).viewInsets;
    final height = size.height - (padding.top + padding.bottom + inset.bottom);
    final width = size.width - (padding.left + padding.right + inset.right);
    final ratio = height / size.width;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: ColorName.pageBackground,
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          children: [
            SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    ArrowBackTitle(
                      title: context.l10n.filmDetail,
                      textSize: 19,
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          height: 200,
                          width: 150,
                          margin: const EdgeInsets.only(right: 15),
                          decoration: BoxDecoration(
                            color: Colors.white54,
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                          ),
                          child: Assets.images.logoPng
                              .image(width: 100, fit: BoxFit.contain),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Ngôi làng của lá và sự trở lại của Mask',
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 17,
                                  color: ColorName.textNormal,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              HighlightCard(
                                widget: Text(
                                  '13+',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: ColorName.textNormal,
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 3),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    rowInformation(
                      title: context.l10n.director,
                      content: 'John Mask',
                      width: width,
                    ),
                    rowInformation(
                      title: context.l10n.cast,
                      content: 'Mikey, Rock, Mandle, Mikey, Rock, Mandle',
                      width: width,
                    ),
                    rowInformation(
                      title: context.l10n.categories,
                      content: 'Tâm lý, hành động',
                      width: width,
                    ),
                    rowInformation(
                      title: context.l10n.runTime,
                      content: '104 phút',
                      width: width,
                    ),
                    rowInformation(
                      title: context.l10n.releaseDate,
                      content: '13/02/2023',
                      width: width,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Cuộc phiêu lưu của cậu bé Max khi trở lại ngôi làng lá của mình sau 12 năm xa cách. Nhóm thợ săn đã truy lùng các thành viên trong bộ lạc của cậu, liệu cậu có giải cứu được họ không?',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 15,
                        color: ColorName.textNormal,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 19,
                          color: ColorName.btnText,
                        ),
                        Text(
                          ' 4.6',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: 15,
                            color: ColorName.textNormal,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Icon(
                          Icons.horizontal_rule,
                          size: 15,
                          color: ColorName.btnText,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          '12 lượt đánh giá',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: 15,
                            color: ColorName.textNormal,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      child: const Divider(
                        color: ColorName.btnText,
                        height: 2,
                      ),
                    ),
                    RateMovieWidget(),
                    RateMovieWidget(),
                    RateMovieWidget(),
                    RateMovieWidget(),
                    RateMovieWidget(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        PrimaryButtonWidget(
                          content: context.l10n.comment,
                          width: 120,
                          onPressed: () {},
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget rowInformation({
    required String title,
    required String content,
    required double width,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: width * 0.3,
            child: Text(
              title,
              style: TextStyle(
                overflow: TextOverflow.clip,
                fontSize: 15,
                color: ColorName.textNormal,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            width: width * 0.6,
            child: Text(
              content,
              style: TextStyle(
                overflow: TextOverflow.clip,
                fontSize: 15,
                color: ColorName.textNormal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
