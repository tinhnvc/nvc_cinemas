import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/feature/m_movie/provider/m_movie_provider.dart';
import 'package:nvc_cinemas/feature/m_revenue/provider/revenue_provider.dart';
import 'package:nvc_cinemas/feature/m_revenue/widget/revenue_item.dart';
import 'package:nvc_cinemas/feature/ticket/provider/ticket_provider.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:nvc_cinemas/l10n/l10n.dart';
import 'package:nvc_cinemas/shared/provider/user_provider.dart';
import 'package:nvc_cinemas/shared/util/format_support.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MRevenuePage extends ConsumerWidget {
  const MRevenuePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    final inset = MediaQuery.of(context).viewInsets;
    final height = size.height - (padding.top + padding.bottom + inset.bottom);
    final width = size.width - (padding.left + padding.right + inset.right);
    final ratio = height / size.width;
    final user = ref.watch(userProvider);
    final movies = ref.watch(moviesProvider)
      ..sort(
        (a, b) => a.startTime!.compareTo(b.startTime!),
      );
    final totalRevenue = ref.read(ticketsProvider.notifier).totalRevenue(ref);
    final totalPromotion =
        ref.read(ticketsProvider.notifier).totalPromotion(ref);
    final isSelectMovie = ref.watch(isSelectRevenueMovieProvider)! as bool;
    final dataPromotion =
        ref.read(ticketsProvider.notifier).revenuePromotion(ref);

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
                margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          context.l10n.revenue,
                          style: TextStyle(
                            color: ColorName.btnText,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => ref
                              .read(isSelectRevenueMovieProvider.notifier)
                              .changed = true,
                          child: Text(
                            context.l10n.movie.toUpperCase(),
                            style: TextStyle(
                              color: ColorName.btnText,
                              fontSize: 17,
                              fontWeight:
                                  isSelectMovie ? FontWeight.bold : null,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () => ref
                              .read(isSelectRevenueMovieProvider.notifier)
                              .changed = false,
                          child: Text(
                            context.l10n.promotions.toUpperCase(),
                            style: TextStyle(
                              color: ColorName.btnText,
                              fontSize: 17,
                              fontWeight:
                                  !isSelectMovie ? FontWeight.bold : null,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    isSelectMovie
                        ? Text(
                            '${context.l10n.totalRevenue}: ${FormatSupport.toMoney(totalRevenue)}đ',
                            style: TextStyle(
                              overflow: TextOverflow.clip,
                              fontSize: 17,
                              color: Colors.green,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        : Text(
                            '${context.l10n.total} ${context.l10n.promotions.toLowerCase()} : ${FormatSupport.toMoney(totalPromotion)}đ',
                            style: TextStyle(
                              overflow: TextOverflow.clip,
                              fontSize: 17,
                              color: Colors.green,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                    const SizedBox(height: 10),
                    isSelectMovie
                        ? Column(
                            children: movies.isNotEmpty
                                ? movies
                                    .map((e) => RevenueItem(
                                          movie: e,
                                        ))
                                    .toList()
                                : [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const SizedBox(
                                          height: 50,
                                        ),
                                        Text(
                                          'Không tìm thấy kết quả nào',
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                          )
                        : SfCartesianChart(
                            primaryXAxis: CategoryAxis(),
                            title: ChartTitle(text: 'Tổng tiền khuyến mãi'),
                            legend: Legend(
                                isVisible: true, position: LegendPosition.top),
                            tooltipBehavior: TooltipBehavior(enable: true),
                            series: [
                              LineSeries(
                                dataSource: dataPromotion,
                                name: context.l10n.promotions,
                                xValueMapper: (datum, index) =>
                                    dataPromotion[index].month,
                                yValueMapper: (datum, index) =>
                                    dataPromotion[index].revenue,
                                dataLabelSettings:
                                    const DataLabelSettings(isVisible: true),
                              )
                            ],
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
