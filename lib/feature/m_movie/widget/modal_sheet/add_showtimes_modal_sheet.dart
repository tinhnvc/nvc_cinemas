import 'package:nvc_cinemas/feature/m_movie/provider/m_movie_provider.dart';
import 'package:nvc_cinemas/feature/m_movie/provider/time_provider.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:nvc_cinemas/l10n/l10n.dart';
import 'package:nvc_cinemas/shared/util/date_time_picker.dart';
import 'package:nvc_cinemas/shared/util/format_support.dart';
import 'package:nvc_cinemas/shared/widget/dropdown_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/shared/widget/information_card.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class AddShowtimesModalSheet extends ConsumerWidget {
  const AddShowtimesModalSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    final inset = MediaQuery.of(context).viewInsets;
    final height = size.height - (padding.top + padding.bottom + inset.bottom);
    final width = size.width - (padding.left + padding.right + inset.right);
    final ratio = height / size.width;
    var timeFrom = ref.watch(startTimeAddShowtimeProvider);
    var timeTo = ref.watch(endTimeAddShowtimeProvider);
    final formGroup = ref.read(timeFormProvider).addShowtimeForm;

    final roomsDropdownList = [
      'P01',
      'P03',
      'P04',
      'P05',
    ];
    final roomValue = ref.watch(roomAddShowtimeProvider);

    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Stack(
            children: [
              Container(
                height: 60,
                padding: const EdgeInsets.only(
                  left: 25,
                  // top: 10,
                  // bottom: 10,
                  right: 5,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${context.l10n.addNew} ${context.l10n.showtimes.toLowerCase()}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Color(0xFF363E59),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 60),
                child: const Divider(
                  height: 3,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 60),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              context.l10n.rooms,
                              style: const TextStyle(
                                color: Color(0xFF363E59),
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                bottom: 10,
                                left: 5,
                                right: width * 0.3,
                              ),
                              child: DropdownWidget(
                                value: roomValue.isNotEmpty ? roomValue : 'P01',
                                values: roomsDropdownList,
                                onChanged: (String value) {
                                  ref
                                      .read(roomAddShowtimeProvider.notifier)
                                      .update(value);
                                },
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      context.l10n.timeShow,
                                      style: const TextStyle(
                                        color: Color(0xFF363E59),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    InformationCard(
                                      content: timeFrom != '0'
                                          ? FormatSupport.toDateTimeNonSecond(
                                              int.parse(timeFrom),
                                            )
                                          : context.l10n.chooseStartDate,
                                      onPressed: () async {
                                        final timePicker = await DateTimePicker
                                            .pickDateTimeInit(
                                                context: context,
                                                initDate: DateTime.now()
                                                    .millisecondsSinceEpoch);
                                        timeFrom = timePicker
                                            .millisecondsSinceEpoch
                                            .toString();
                                        ref
                                            .read(startTimeAddShowtimeProvider
                                                .notifier)
                                            .update(timeFrom);
                                        formGroup.control('from').value =
                                            timeFrom;

                                        timeTo = timePicker
                                            .add(Duration(minutes: 90))
                                            .millisecondsSinceEpoch
                                            .toString();
                                        ref
                                            .read(endTimeAddShowtimeProvider
                                                .notifier)
                                            .update(timeTo);
                                        formGroup.control('to').value = timeTo;
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
                              height: 10,
                            ),
                            Text(
                              '${context.l10n.endShow}: '
                              '${timeTo != '0' ? FormatSupport.toDateTimeNonSecond(
                                  int.parse(timeTo),
                                ) : context.l10n.notUpdated}',
                              style: const TextStyle(
                                color: Color(0xFF363E59),
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  '${context.l10n.status}:',
                                  style: const TextStyle(
                                    color: Color(0xFF363E59),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  context.l10n.empty,
                                  style: const TextStyle(
                                    color: Colors.green,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          right: 25,
                          bottom: 20,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text(
                                context.l10n.back,
                                style: const TextStyle(
                                  color: Color(0xFF363E59),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            RoundedLoadingButton(
                              color: ColorName.primary,
                              borderRadius: 5,
                              height: 40,
                              width: 110,
                              animateOnTap: false,
                              controller:
                                  ref.watch(movieFormProvider).buttonController,
                              onPressed: () {},
                              child: Text(
                                context.l10n.addNew,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
