import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/feature/m_room/model/seat_model.dart';
import 'package:nvc_cinemas/feature/ticket/model/ticket_model.dart';
import 'package:nvc_cinemas/shared/enum/navigation_item.dart';
import 'package:nvc_cinemas/shared/link/tickets.dart';
import 'package:nvc_cinemas/shared/provider/navigation_provider.dart';
import 'package:nvc_cinemas/shared/provider/user_provider.dart';
import 'package:nvc_cinemas/shared/util/function_ulti.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

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
      if (item.timeId == timeId) {
        result.add(item.seatId!);
      }
    }
    return result;
  }

  bool allowBookTicket(WidgetRef ref, String movieId) {
    final user = ref.watch(userProvider);
    var count = 0;
    for (final item in state) {
      if (item.userId == user.userId! && item.status == 'waitPay') {
        count++;
      }
    }
    return count <= 2;
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
}
