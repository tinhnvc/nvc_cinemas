import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/feature/m_category/widget/category_item.dart';
import 'package:nvc_cinemas/feature/m_movie/provider/time_provider.dart';
import 'package:nvc_cinemas/feature/m_movie/widget/m_movie_item.dart';
import 'package:nvc_cinemas/feature/m_ticket/widget/m_ticket_item.dart';
import 'package:nvc_cinemas/feature/ticket/model/ticket_model.dart';
import 'package:nvc_cinemas/feature/ticket/provider/ticket_provider.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:nvc_cinemas/l10n/l10n.dart';
import 'package:nvc_cinemas/shared/provider/user_provider.dart';
import 'package:nvc_cinemas/shared/util/date_time_picker.dart';
import 'package:nvc_cinemas/shared/util/format_support.dart';
import 'package:nvc_cinemas/shared/util/init_util.dart';
import 'package:nvc_cinemas/shared/widget/information_card.dart';
import 'package:nvc_cinemas/shared/widget/rounded_button_widget.dart';
import 'package:nvc_cinemas/shared/widget/search_widget.dart';

class MTicketPage extends ConsumerWidget {
  const MTicketPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    final inset = MediaQuery.of(context).viewInsets;
    final height = size.height - (padding.top + padding.bottom + inset.bottom);
    final width = size.width - (padding.left + padding.right + inset.right);
    final ratio = height / size.width;
    final user = ref.watch(userProvider);
    var timeFrom = ref.watch(startTimeFilterMovieProvider);
    var timeTo = ref.watch(endTimeFilterMovieProvider);

    final allTickets = ref.watch(ticketsProvider);
    // ..sort(
    // (a, b) => -a.createAt!.compareTo(b.createAt!),
    // );
    var tickets = <TicketModel>[];

    if (timeFrom != '0') {
      for (final item in allTickets) {
        final time = ref.read(timesProvider.notifier).getById(item.timeId!);
        if (time.from! > int.parse(timeFrom) && time.to! < int.parse(timeTo)) {
          tickets.add(item);
        }
      }
      tickets.sort((a, b) => -a.createAt!.compareTo(b.createAt!));
    } else {
      tickets = allTickets
        ..sort(
          (a, b) => -a.createAt!.compareTo(b.createAt!),
        );
    }

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
                          context.l10n.ticket,
                          style: TextStyle(
                            color: ColorName.btnText,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SearchWidget(searchHint: 'Hạnh phúc của gia đình Tom'),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InformationCard(
                                  content: timeFrom != '0'
                                      ? FormatSupport.toDateTimeNonHour(
                                          int.parse(timeFrom),
                                        )
                                      : context.l10n.chooseStartDate,
                                  onPressed: () async {
                                    final dateRange =
                                        await DateTimePicker.pickDateRange(
                                      context: context,
                                      start: int.parse(timeFrom),
                                      end: int.parse(timeTo),
                                    );
                                    timeFrom = dateRange
                                        .start.millisecondsSinceEpoch
                                        .toString();
                                    ref
                                        .read(startTimeFilterMovieProvider
                                            .notifier)
                                        .update(timeFrom);
                                    timeFrom;

                                    timeTo = (dateRange.end
                                                .add(const Duration(days: 1))
                                                .millisecondsSinceEpoch -
                                            1)
                                        .toString();
                                    ref
                                        .read(
                                            endTimeFilterMovieProvider.notifier)
                                        .update(timeTo);
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.date_range_rounded,
                              size: 30,
                              color: ColorName.primary,
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InformationCard(
                                  content: timeFrom != '0'
                                      ? FormatSupport.toDateTimeNonHour(
                                          int.parse(timeTo),
                                        )
                                      : context.l10n.chooseToDate,
                                  onPressed: () async {
                                    final dateRange =
                                        await DateTimePicker.pickDateRange(
                                      context: context,
                                      start: int.parse(timeFrom),
                                      end: int.parse(timeTo),
                                    );
                                    timeFrom = dateRange
                                        .start.millisecondsSinceEpoch
                                        .toString();
                                    ref
                                        .read(startTimeFilterMovieProvider
                                            .notifier)
                                        .update(timeFrom);

                                    timeTo = (dateRange.end
                                                .add(const Duration(days: 1))
                                                .millisecondsSinceEpoch -
                                            1)
                                        .toString();
                                    ref
                                        .read(
                                            endTimeFilterMovieProvider.notifier)
                                        .update(timeTo);
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.date_range_rounded,
                              size: 30,
                              color: ColorName.primary,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Có ${tickets.length} kết quả',
                      style: TextStyle(
                        fontSize: 14,
                        color: ColorName.textNormal,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    RoundedButtonWidget(
                        content: 'Làm mới',
                        onPressed: () {
                          InitUtil.initMTicketPage(ref: ref);
                        }),
                    const SizedBox(height: 10),
                    Column(
                      children: tickets.isNotEmpty
                          ? tickets
                              .map((e) => MTicketItem(
                                    ticket: e,
                                  ))
                              .toList()
                          : [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
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
