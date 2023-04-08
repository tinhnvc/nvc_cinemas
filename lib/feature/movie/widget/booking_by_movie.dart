import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/feature/movie/widget/date_booking_widget.dart';
import 'package:nvc_cinemas/feature/movie/widget/time_booking_widget.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:nvc_cinemas/l10n/l10n.dart';
import 'package:nvc_cinemas/shared/widget/arrow_back_title.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class BookingByMovie extends ConsumerWidget {
  const BookingByMovie({Key? key}) : super(key: key);

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
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    ArrowBackTitle(
                      title: context.l10n.bookingByMovie,
                      textSize: 19,
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Ngôi làng của lá',
                      style: TextStyle(
                        color: ColorName.btnText,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Tâm lý, hành động | 104 phút',
                      style: TextStyle(
                        color: ColorName.btnText,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    DialogButton(
                      color: ColorName.primary,
                      radius: const BorderRadius.all(Radius.circular(5)),
                      height: 40,
                      width: 150,
                      onPressed: () =>
                          Navigator.pushNamed(context, '/movie-detail'),
                      child: Text(
                        context.l10n.filmDetail,
                        style: const TextStyle(
                          color: ColorName.btnText,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
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
                    Row(
                      children: [
                        Text(
                          context.l10n.twoDimensionalSubtitle,
                          style: TextStyle(
                            color: ColorName.btnText,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
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
                          TimeBookingWidget(
                            time: '11:20',
                            seat: '25 trống',
                          ),
                          TimeBookingWidget(
                            time: '14:10',
                            seat: '30 trống',
                          ),
                          TimeBookingWidget(
                            time: '21:00',
                            seat: '12 trống',
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
}
