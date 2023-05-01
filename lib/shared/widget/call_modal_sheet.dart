import 'package:flutter/material.dart';
import 'package:nvc_cinemas/feature/m_movie/model/time_model.dart';
import 'package:nvc_cinemas/feature/m_movie/widget/modal_sheet/add_showtimes_modal_sheet.dart';
import 'package:nvc_cinemas/feature/m_movie/widget/modal_sheet/edit_showtimes_modal_sheet.dart';
import 'package:nvc_cinemas/feature/movie/model/movie_model.dart';
import 'package:nvc_cinemas/feature/movie/widget/comment_widget.dart';
import 'package:nvc_cinemas/feature/payment/widget/payment_qr.dart';
import 'package:nvc_cinemas/feature/payment/widget/payment_qr_later.dart';
import 'package:nvc_cinemas/feature/user/widget/edit_account_information.dart';

class CallModalSheet {
  static Future<void> showPaymentQrModalSheet(
    BuildContext context,
    Map<String, dynamic> args,
  ) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      barrierColor: Colors.black.withOpacity(0.2),
      backgroundColor: Colors.transparent,
      builder: (context) => PaymentQrModalSheet(args: args),
    );
  }

  static Future<void> showPaymentQrLaterModalSheet(
    BuildContext context,
    Map<String, dynamic> args,
  ) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      barrierColor: Colors.black.withOpacity(0.2),
      backgroundColor: Colors.transparent,
      builder: (context) => PaymentQrLaterModalSheet(args: args),
    );
  }

  static Future<void> editAccountInformation(
    BuildContext context,
  ) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      barrierColor: Colors.black.withOpacity(0.2),
      backgroundColor: Colors.transparent,
      builder: (context) => EditAccountInformationModalSheet(),
    );
  }

  static Future<void> commentMovie(
    BuildContext context,
    MovieModel movie,
  ) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      barrierColor: Colors.black.withOpacity(0.2),
      backgroundColor: Colors.transparent,
      builder: (context) => CommentModalSheet(
        movie: movie,
      ),
    );
  }

  static Future<void> addShowtimes(
    BuildContext context,
    MovieModel movie,
  ) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      barrierColor: Colors.black.withOpacity(0.2),
      backgroundColor: Colors.transparent,
      builder: (context) => AddShowtimesModalSheet(movie: movie),
    );
  }

  static Future<void> editShowtimes(
    BuildContext context,
    MovieModel movie,
    TimeModel time,
  ) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      barrierColor: Colors.black.withOpacity(0.2),
      backgroundColor: Colors.transparent,
      builder: (context) => EditShowtimesModalSheet(
        movie: movie,
        time: time,
      ),
    );
  }
}
