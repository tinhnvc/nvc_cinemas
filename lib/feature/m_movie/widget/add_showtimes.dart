import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/feature/m_category/provider/category_provider.dart';
import 'package:nvc_cinemas/feature/m_movie/provider/m_movie_provider.dart';
import 'package:nvc_cinemas/feature/m_movie/widget/m_showtimes_item.dart';
import 'package:nvc_cinemas/feature/movie/widget/date_booking_widget.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:nvc_cinemas/l10n/l10n.dart';
import 'package:nvc_cinemas/shared/widget/arrow_back_title.dart';
import 'package:nvc_cinemas/shared/widget/call_modal_sheet.dart';
import 'package:nvc_cinemas/shared/widget/dropdown_widget.dart';
import 'package:nvc_cinemas/shared/widget/form_text_field.dart';
import 'package:nvc_cinemas/shared/widget/information_card.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class AddShowtimes extends ConsumerWidget {
  const AddShowtimes({Key? key}) : super(key: key);

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
                      title: context.l10n.showtimes,
                      textSize: 19,
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    rowInformation(
                      title: context.l10n.movie,
                      content: 'Ngôi làng của lá và sự trở lại của Max',
                      width: width,
                    ),
                    rowInformation(
                      title: context.l10n.runTime,
                      content: '105 ${context.l10n.minutes.toLowerCase()}',
                      width: width,
                    ),
                    rowInformation(
                      title: context.l10n.releaseShow,
                      content: '12/03/2023',
                      width: width,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: width,
                      height: 60,
                      child: ListView(
                        physics: AlwaysScrollableScrollPhysics(
                            parent: BouncingScrollPhysics()),
                        scrollDirection: Axis.horizontal,
                        children: [
                          DateBookingWidget(
                            date: '13',
                            dayOfWeek: 'Hôm nay',
                            isSelect: true,
                          ),
                          DateBookingWidget(
                            date: '14',
                            dayOfWeek: '02 - T3',
                            isSelect: false,
                          ),
                          DateBookingWidget(
                            date: '15',
                            dayOfWeek: '02 - T4',
                            isSelect: false,
                          ),
                          DateBookingWidget(
                            date: '16',
                            dayOfWeek: '02 - T5',
                            isSelect: false,
                          ),
                          DateBookingWidget(
                            date: '17',
                            dayOfWeek: '02 - T6',
                            isSelect: false,
                          ),
                          DateBookingWidget(
                            date: '18',
                            dayOfWeek: '02 - T7',
                            isSelect: false,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${context.l10n.all} ${context.l10n.showtimes.toLowerCase()}',
                      style: TextStyle(
                        color: ColorName.btnText,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MShowtimesItem(),
                    MShowtimesItem(),
                    MShowtimesItem(),
                    GestureDetector(
                      onTap: () => CallModalSheet.addShowtimes(context),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.add_box_outlined,
                            size: 35,
                            color: ColorName.primary,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${context.l10n.addNew}',
                            style: TextStyle(
                              color: ColorName.primary,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
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
