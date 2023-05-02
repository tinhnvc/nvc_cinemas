import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/feature/movie/model/movie_model.dart';
import 'package:nvc_cinemas/feature/ticket/provider/ticket_provider.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:nvc_cinemas/l10n/l10n.dart';
import 'package:nvc_cinemas/shared/provider/util_provider.dart';
import 'package:nvc_cinemas/shared/util/format_support.dart';
import 'package:nvc_cinemas/shared/widget/arrow_back_title.dart';
import 'package:nvc_cinemas/shared/widget/select/selectable_text_custom.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class RevenueDetail extends ConsumerWidget {
  const RevenueDetail({required this.movie, Key? key}) : super(key: key);
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
    final ticketAmount = ref
        .read(ticketsProvider.notifier)
        .ticketAmountByMovieId(ref, movie.id!);
    final total =
        ref.read(ticketsProvider.notifier).totalByMovieId(ref, movie.id!);
    final data =
        ref.read(ticketsProvider.notifier).revenueByMovie(ref, movie.id!);

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
                      title: context.l10n.revenueDetail,
                      textSize: 19,
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${context.l10n.film}: '
                      '${isVietnamese ? movie.movieNameVi ?? context.l10n.notUpdated : movie.movieNameEn ?? context.l10n.notUpdated}',
                      style: TextStyle(
                        overflow: TextOverflow.clip,
                        fontSize: 16,
                        color: ColorName.textNormal,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      '${context.l10n.ticketAmount}: $ticketAmount',
                      style: TextStyle(
                        overflow: TextOverflow.clip,
                        fontSize: 16,
                        color: ColorName.textNormal,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      title: ChartTitle(
                          text:
                              '${context.l10n.revenue} ${isVietnamese ? movie.movieNameVi ?? context.l10n.notUpdated : movie.movieNameEn ?? context.l10n.notUpdated}'),
                      legend:
                          Legend(isVisible: true, position: LegendPosition.top),
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: [
                        LineSeries(
                          dataSource: data,
                          name: context.l10n.revenue,
                          xValueMapper: (datum, index) => data[index].month,
                          yValueMapper: (datum, index) => data[index].revenue,
                          dataLabelSettings:
                              const DataLabelSettings(isVisible: true),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '${context.l10n.totalRevenue}: ${FormatSupport.toMoney(total)}đ',
                          style: TextStyle(
                            overflow: TextOverflow.clip,
                            fontSize: 17,
                            color: Colors.green,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
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

  Widget rowInformation({
    required String title,
    required String content,
    required double width,
    bool? isSpecial,
    bool? isSelectable,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
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
                fontWeight: isSpecial ?? false ? FontWeight.w600 : null,
              ),
            ),
          ),
          Expanded(
            child: isSelectable ?? false
                ? SelectableTextCustom(
                    text: content,
                    style: TextStyle(
                      overflow: TextOverflow.clip,
                      fontSize: 15,
                      color: ColorName.textNormal,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                : Text(
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

  Widget rowStatusTicket({
    required BuildContext context,
    required String status,
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
              context.l10n.status,
              style: TextStyle(
                overflow: TextOverflow.clip,
                fontSize: 15,
                color: ColorName.textNormal,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: status == context.l10n.payed ? Colors.green : Colors.red,
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(15),
                right: Radius.circular(15),
              ),
            ),
            child: Text(
              status,
              style: TextStyle(
                overflow: TextOverflow.clip,
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
