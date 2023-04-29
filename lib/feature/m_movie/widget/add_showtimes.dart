import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/feature/m_movie/provider/time_provider.dart';
import 'package:nvc_cinemas/feature/m_movie/widget/m_showtimes_item.dart';
import 'package:nvc_cinemas/feature/movie/model/movie_model.dart';
import 'package:nvc_cinemas/feature/movie/provider/day_of_week_provider.dart';
import 'package:nvc_cinemas/feature/movie/widget/date_booking_widget.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:nvc_cinemas/l10n/l10n.dart';
import 'package:nvc_cinemas/shared/provider/util_provider.dart';
import 'package:nvc_cinemas/shared/util/format_support.dart';
import 'package:nvc_cinemas/shared/util/init_util.dart';
import 'package:nvc_cinemas/shared/widget/arrow_back_title.dart';
import 'package:nvc_cinemas/shared/widget/call_modal_sheet.dart';

class AddShowtimes extends ConsumerWidget {
  const AddShowtimes({required this.movie, Key? key}) : super(key: key);
  final MovieModel movie;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    final inset = MediaQuery.of(context).viewInsets;
    final height = size.height - (padding.top + padding.bottom + inset.bottom);
    final width = size.width - (padding.left + padding.right + inset.right);
    final ratio = height / size.width;
    final isVietnamese = ref.watch(languageProvider) == 'vi';
    final weekMap = ref.watch(dayOfWeekProvider);
    final timesShowByDay =
        ref.read(timesProvider.notifier).getByDay(ref: ref, movieId: movie.id!);

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
                      content: isVietnamese
                          ? movie.movieNameVi ?? context.l10n.notUpdated
                          : movie.movieNameEn ?? context.l10n.notUpdated,
                      width: width,
                    ),
                    rowInformation(
                      title: context.l10n.runTime,
                      content:
                          '${movie.duration} ${context.l10n.minutes.toLowerCase()}',
                      width: width,
                    ),
                    rowInformation(
                      title: context.l10n.releaseShow,
                      content:
                          '${FormatSupport.toDateTimeNonHour(movie.startTime!)}',
                      width: width,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: width,
                      height: 70,
                      child: ListView(
                        physics: AlwaysScrollableScrollPhysics(
                            parent: BouncingScrollPhysics()),
                        scrollDirection: Axis.horizontal,
                        children: weekMap
                            .map(
                              (e) => GestureDetector(
                                onTap: () {
                                  ref
                                      .read(dayOfWeekProvider.notifier)
                                      .onceSelect(e.id!);
                                },
                                child: DateBookingWidget(
                                  date: DateTime.fromMillisecondsSinceEpoch(
                                          e.day!)
                                      .day
                                      .toString(),
                                  dayOfWeek: DateTime
                                                  .fromMillisecondsSinceEpoch(
                                                      e.day!)
                                              .day ==
                                          DateTime.now().day
                                      ? '${e.dayOfWeek}'
                                      : '0${DateTime.fromMillisecondsSinceEpoch(e.day!).month.toString()} - ${e.dayOfWeek}',
                                  isSelect: e.isSelected ?? false,
                                ),
                              ),
                            )
                            .toList(),
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
                    SizedBox(
                      width: width,
                      height: 250,
                      child: ListView(
                        physics: AlwaysScrollableScrollPhysics(
                            parent: BouncingScrollPhysics()),
                        scrollDirection: Axis.vertical,
                        children: timesShowByDay.isNotEmpty
                            ? timesShowByDay.map((e) {
                                return GestureDetector(
                                    onTap: () {},
                                    child: MShowtimesItem(
                                      time: e,
                                    ));
                              }).toList()
                            : [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      context.l10n.noShowtime,
                                      style: TextStyle(
                                        color: ColorName.btnText,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        InitUtil.initAddShowtime(ref: ref);
                        CallModalSheet.addShowtimes(context);
                      },
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
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
