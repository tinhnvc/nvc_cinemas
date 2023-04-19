import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/feature/m_movie/provider/time_provider.dart';
import 'package:nvc_cinemas/feature/movie/provider/day_of_week_provder.dart';
import 'package:nvc_cinemas/feature/movie/widget/date_booking_widget.dart';
import 'package:nvc_cinemas/feature/movie/widget/time_booking_widget.dart';
import 'package:nvc_cinemas/feature/showtimes/widget/movie_showtimes_widget.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:nvc_cinemas/l10n/l10n.dart';
import 'package:nvc_cinemas/shared/provider/user_provider.dart';
import 'package:nvc_cinemas/shared/widget/rounded_button_widget.dart';

class ShowtimesPage extends ConsumerWidget {
  const ShowtimesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    final inset = MediaQuery.of(context).viewInsets;
    final height = size.height - (padding.top + padding.bottom + inset.bottom);
    final width = size.width - (padding.left + padding.right + inset.right);
    final ratio = height / size.width;
    final user = ref.watch(userProvider);
    final weekMap = ref.watch(dayOfWeekProvider);
    final daySelect = ref.read(dayOfWeekProvider.notifier).getSelected();
    final listMovieOfDay =
        ref.read(timesProvider.notifier).getMovieByDay(ref, daySelect.day!);

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
                height: listMovieOfDay.isEmpty ? height * 0.8 : null,
                margin: const EdgeInsets.only(left: 20, right: 20),
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new ExactAssetImage('assets/images/logo-png.png'),
                    fit: BoxFit.contain,
                  ),
                ),
                child: BackdropFilter(
                  filter: new ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                  child: Container(
                    decoration: new BoxDecoration(
                      color: ColorName.pageBackground.withOpacity(0.7),
                    ),
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const SizedBox(height: 20),
                        Text(
                          context.l10n.bookingByTime,
                          style: TextStyle(
                            color: ColorName.btnText,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
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
                          height: 20,
                        ),
                        listMovieOfDay.isNotEmpty
                            ? Column(
                                children: listMovieOfDay
                                    .map((e) => MovieShowtimesWidget(movie: e))
                                    .toList(),
                              )
                            : Text(
                                context.l10n.noMovieToday,
                                style: TextStyle(
                                  color: ColorName.btnText,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
