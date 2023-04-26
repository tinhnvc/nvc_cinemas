import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/feature/ticket/model/ticket_model.dart';
import 'package:nvc_cinemas/feature/ticket/provider/ticket_provider.dart';
import 'package:nvc_cinemas/feature/ticket/widget/ticket_item.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:nvc_cinemas/l10n/l10n.dart';
import 'package:nvc_cinemas/shared/provider/user_provider.dart';
import 'package:nvc_cinemas/shared/widget/arrow_back_title.dart';
import 'package:path/path.dart';

class TicketPage extends ConsumerWidget {
  const TicketPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    final inset = MediaQuery.of(context).viewInsets;
    final height = size.height - (padding.top + padding.bottom + inset.bottom);
    final width = size.width - (padding.left + padding.right + inset.right);
    final ratio = height / size.width;
    final user = ref.watch(userProvider);
    final tickets = ref.watch(ticketsProvider);
    print(tickets);
    final ticketByUser = <TicketModel>[];

    if (tickets.isNotEmpty) {
      for (final item in tickets) {
        if (item.userId == user.userId) {
          ticketByUser.add(item);
        }
      }
    }
    ticketByUser..sort((a, b) => a.createAt!.compareTo(b.createAt!));

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: ColorName.pageBackground,
      // endDrawer: const EndDrawerWidget(),
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
                      title: context.l10n.ticket,
                      textSize: 19,
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ticketByUser.isEmpty
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Khách hàng hiện chưa có vé nào.\nLựa chọn phim muốn xem và đặt vé nhé!',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  overflow: TextOverflow.clip,
                                  fontSize: 18,
                                  color: ColorName.textNormal,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          )
                        : Column(
                            children: ticketByUser
                                .map((e) => TicketItem(ticket: e))
                                .toList(),
                          )
                    // TicketItem(isPayed: true),
                    // TicketItem(isPayed: false),
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
