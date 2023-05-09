import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/feature/auth/provider/users_provider.dart';
import 'package:nvc_cinemas/feature/m_movie/provider/m_movie_provider.dart';
import 'package:nvc_cinemas/feature/m_movie/provider/time_provider.dart';
import 'package:nvc_cinemas/feature/m_room/model/seat_model.dart';
import 'package:nvc_cinemas/feature/m_room/provider/m_room_provider.dart';
import 'package:nvc_cinemas/feature/m_room/provider/m_seat_provider.dart';
import 'package:nvc_cinemas/feature/ticket/model/ticket_model.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:nvc_cinemas/l10n/l10n.dart';
import 'package:nvc_cinemas/shared/enum/navigation_item.dart';
import 'package:nvc_cinemas/shared/link/email_sender.dart';
import 'package:nvc_cinemas/shared/link/tickets.dart';
import 'package:nvc_cinemas/shared/provider/navigation_provider.dart';
import 'package:nvc_cinemas/shared/provider/user_provider.dart';
import 'package:nvc_cinemas/shared/util/format_support.dart';
import 'package:nvc_cinemas/shared/util/function_ulti.dart';
import 'package:one_context/one_context.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import 'package:http/http.dart' as http;

final ticketsProvider =
    StateNotifierProvider<MoviesNotifier, List<TicketModel>>(
  (ref) => MoviesNotifier(),
);

class MoviesNotifier extends StateNotifier<List<TicketModel>> {
  MoviesNotifier() : super([]) {
    fetchTimes();
  }

  Future<void> fetchTimes() async {
    final ticketFetch = ticketsFromJson(tickets);
    state = ticketFetch;
  }

  TicketModel getById(String id) {
    var ticket = const TicketModel();
    if (state.isNotEmpty) {
      for (final item in state) {
        if (item.id == id) {
          ticket = item;
        }
      }
    }

    return ticket;
  }

  void add(TicketModel ticket) {
    state = [...state, ticket];
  }

  List<String> getSeatsIdByTimeId(String timeId) {
    var result = <String>[];
    for (final item in state) {
      if (item.timeId == timeId && item.status != 'canceled') {
        result.add(item.seatId!);
      }
    }
    return result;
  }

  bool allowBookTicket(WidgetRef ref, String movieId) {
    final user = ref.watch(userProvider);
    var count = 0;
    var countConfirm = 0;
    for (final item in state) {
      if (item.userId == user.userId! && item.status == 'waitPay') {
        count++;
      }
    }
    for (final item in state) {
      if (item.userId == user.userId! && item.status == 'waitConfirm') {
        countConfirm++;
      }
    }
    return count <= 2 && countConfirm <=2;
  }

  void waitConfirm(String id) {
    state = [
      for (final item in state)
        if (item.id == id) item.copyWith(status: 'waitConfirm') else item,
    ];
  }

  void confirm(String id) {
    state = [
      for (final item in state)
        if (item.id == id) item.copyWith(status: 'payed') else item,
    ];
  }

  void cancel(String id) {
    state = [
      for (final item in state)
        if (item.id == id) item.copyWith(status: 'canceled') else item,
    ];
  }

  int ticketAmountByMovieId(WidgetRef ref, String movieId) {
    var count = 0;
    if (state.isNotEmpty) {
      for (final item in state) {
        final time = ref.read(timesProvider.notifier).getById(item.timeId!);
        if (time.movieId == movieId && item.status == 'payed') {
          count++;
        }
      }
    }
    return count;
  }

  int totalByMovieId(WidgetRef ref, String movieId) {
    var total = 0;

    if (state.isNotEmpty) {
      for (final item in state) {
        final time = ref.read(timesProvider.notifier).getById(item.timeId!);
        if (time.movieId == movieId && item.status == 'payed') {
          total += item.totalPrice ?? 45000;
        }
      }
    }
    return total;
  }

  List<RevenueData> revenueByMovie(WidgetRef ref, String movieId) {
    var result = <RevenueData>[];
    final month = [1, 2, 3, 4, 5];
    for (final item in month) {
      var revenueInMonth = 0;
      for (final ticket in state) {
        final time = ref.read(timesProvider.notifier).getById(ticket.timeId!);
        if (DateTime.fromMillisecondsSinceEpoch(time.from!).month == item &&
            time.movieId == movieId &&
            ticket.status == 'payed') {
          revenueInMonth += ticket.totalPrice ?? 45000;
        }
      }
      result.add(RevenueData('Tháng $item', revenueInMonth.toDouble()));
    }

    return result;
  }

  List<RevenueData> revenuePromotion(WidgetRef ref) {
    var result = <RevenueData>[];
    final month = [1, 2, 3, 4, 5];
    for (final item in month) {
      var revenueInMonth = 0;
      for (final ticket in state) {
        final time = ref.read(timesProvider.notifier).getById(ticket.timeId!);
        if (DateTime.fromMillisecondsSinceEpoch(time.from!).month == item &&
            ticket.status == 'payed') {
          revenueInMonth += ticket.discount ?? 15000;
        }
      }
      result.add(RevenueData('Tháng $item', revenueInMonth.toDouble()));
    }

    return result;
  }

  int totalRevenue(WidgetRef ref) {
    var total = 0;

    if (state.isNotEmpty) {
      for (final item in state) {
        if (item.status == 'payed') {
          total += item.totalPrice ?? 45000;
        }
      }
    }
    return total;
  }

  int totalPromotion(WidgetRef ref) {
    var total = 0;

    if (state.isNotEmpty) {
      for (final item in state) {
        if (item.status == 'payed') {
          total += item.discount ?? 15000;
        }
      }
    }
    return total;
  }
}

final ticketFormProvider = Provider<TicketFormProvider>(
  (ref) => TicketFormProvider(),
);

class TicketFormProvider {
  TicketFormProvider();

  final addCategoryForm = FormGroup({
    'categoryName': FormControl<String>(),
    'description': FormControl<String>(),
  });

  final buttonController = RoundedLoadingButtonController();

  Future<void> addTicket(
    WidgetRef ref,
    BuildContext context,
    TicketModel ticket,
  ) async {
    buttonController.start();
    await Future.delayed(const Duration(milliseconds: 700));
    ref.read(ticketsProvider.notifier).add(ticket);
    print(ticket);
    FunctionUtil.alertPopUpPayed(onPressedConfirm: () {
      ref
          .read(navigationProvider.notifier)
          .setNavigationItem(NavigationItem.home);
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/home-page',
        (Route<dynamic> route) => false,
      );
    });
    buttonController.reset();
  }

  Future<void> waitConfirmTicket(
    WidgetRef ref,
    BuildContext context,
    TicketModel ticket,
  ) async {
    buttonController.start();
    await Future.delayed(const Duration(milliseconds: 700));
    ref.read(ticketsProvider.notifier).waitConfirm(ticket.id!);
    buttonController.reset();
    Navigator.pop(context);
  }

  Future<void> confirmTicket(
    WidgetRef ref,
    BuildContext context,
    TicketModel ticket,
  ) async {
    buttonController.start();
    ref.read(ticketsProvider.notifier).confirm(ticket.id!);
    buttonController.reset();
  }

  Future<void> cancelTicket(
    WidgetRef ref,
    BuildContext context,
    TicketModel ticket,
  ) async {
    buttonController.start();
    ref.read(ticketsProvider.notifier).cancel(ticket.id!);
    buttonController.reset();
  }

  Future<void> sendEmailBookTicketSuccess({
    required WidgetRef ref,
    required TicketModel ticket,
  }) async {
    final time = ref.read(timesProvider.notifier).getById(ticket.timeId!);
    final movie = ref.read(moviesProvider.notifier).getById(time.movieId!);
    final room = ref.read(roomsProvider.notifier).getById(time.roomId!);
    final seat = ref.read(seatsProvider.notifier).getById(ticket.seatId!);
    final user = ref.read(usersProvider.notifier).getById(ticket.userId!);

    final url = Uri.parse(urlSendEmail);
    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'service_id': serviceId,
          'template_id': templateBookingId,
          'user_id': userId,
          'accessToken': privateKey,
          'template_params': {
            'to_email': user.email,
            'to_name': user.fullName,
            'confirm_time': FormatSupport.toDateTimeNonSecond(ticket.updateAt!),
            'ticket_id': ticket.id,
            'time_show': FormatSupport.toDateTimeNonSecond(time.from!),
            'movie_name': movie.movieNameVi,
            'room': room.name,
            'seat': seat.position,
            'total': '${FormatSupport.toMoney(ticket.totalPrice!)}đ',
          }
        }));
    print('Send request booking ticket: ${response.body}');
    if (response.body == 'OK') {
      confirmTicketSuccessPopup();
    }
  }

  void confirmTicketSuccessPopup() {
    final ctx = OneContext().context;
    if (ctx != null) {
      Alert(
        context: ctx,
        type: AlertType.success,
        title: ctx.l10n.success,
        desc: 'Đã hoàn thành vé\nThông báo đã gửi tới khách hàng',
        style: const AlertStyle(
          titleStyle: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
          descStyle: TextStyle(
            fontSize: 15,
          ),
        ),
        buttons: [
          DialogButton(
            color: ColorName.primary,
            radius: const BorderRadius.all(Radius.circular(5)),
            height: 44,
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              ctx.l10n.ok,
              style: const TextStyle(
                color: ColorName.btnText,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ).show();
    }
  }
}

final startTimeFilterMovieProvider =
    StateNotifierProvider<StartTimeFilterMovieNotifier, String>(
  (ref) => StartTimeFilterMovieNotifier(),
);

class StartTimeFilterMovieNotifier extends StateNotifier<String> {
  StartTimeFilterMovieNotifier() : super('0');

  void update(String value) {
    state = value;
  }
}

final endTimeFilterMovieProvider =
    StateNotifierProvider<EndTimeFilterMovieNotifier, String>(
  (ref) => EndTimeFilterMovieNotifier(),
);

class EndTimeFilterMovieNotifier extends StateNotifier<String> {
  EndTimeFilterMovieNotifier() : super('0');

  void update(String value) {
    state = value;
  }
}

class RevenueData {
  RevenueData(this.month, this.revenue);

  final String month;
  final double revenue;
}
