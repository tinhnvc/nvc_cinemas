import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/feature/auth/provider/auth_provider.dart';
import 'package:nvc_cinemas/feature/m_category/provider/category_provider.dart';
import 'package:nvc_cinemas/feature/m_movie/model/time_model.dart';
import 'package:nvc_cinemas/feature/m_room/provider/m_seat_provider.dart';
import 'package:nvc_cinemas/feature/movie/model/category_model.dart';
import 'package:nvc_cinemas/feature/movie/provider/movie_rating_provider.dart';
import 'package:nvc_cinemas/feature/ticket/provider/ticket_provider.dart';
import 'package:nvc_cinemas/shared/provider/util_provider.dart';
import 'package:nvc_cinemas/shared/repository/language_repository.dart';
import 'package:nvc_cinemas/feature/movie/provider/day_of_week_provider.dart';

class InitUtil {
  static void initSignUpForm(
    WidgetRef ref,
  ) {
    final formGroup = ref.read(authProvider).signUpForm;
    formGroup.control('email').value = ' ';
    formGroup.control('password').value = ' ';
    formGroup.control('phoneNumber').value = ' ';
    formGroup.control('fullName').value = ' ';
    formGroup.control('gender').value = 'unknown';
    formGroup.control('yob').value = ' ';
    formGroup.reset();
    ref
      ..refresh(isAcceptTerms)
      ..refresh(genderSignUpProvider);
  }

  static void initSetting(WidgetRef ref) async {
    final languageSave =
        await ref.read(languageRepositoryProvider).fetchLanguage();
    ref.read(appLanguage.notifier).changed =
        languageSave == 'vi' ? true : false;
  }

  static void initComment({
    required WidgetRef ref,
    required String userId,
    required String movieId,
  }) async {
    final formGroup = ref.read(movieRatingFormProvider).addCommentForm;
    formGroup.control('userId').value = userId;
    formGroup.control('movieId').value = movieId;
    formGroup.control('star').value = '5';
    formGroup.control('comment').value = '';
  }

  static void initBookingByMovie({
    required WidgetRef ref,
  }) async {
    ref
        .read(dayOfWeekProvider.notifier)
        .statusChangedDefault('c1d8b61c-fc54-4ec9-a9af-16ce093c93a1');
  }

  static void initBookingByMovieDetail({
    required WidgetRef ref,
    required TimeModel time,
  }) async {
    ref.read(seatsProvider.notifier)
      ..cleanStatus()
      ..cleanStatusSold();
    final soldSeats =
        ref.read(ticketsProvider.notifier).getSeatsIdByTimeId(time.id!);
    ref.read(seatsProvider.notifier).setSoldSeat(soldSeats);
  }

  static void initEditCategory({
    required WidgetRef ref,
    required CategoryModel category,
  }) async {
    final formGroup = ref.read(categoryFormProvider).addCategoryForm;
    formGroup.control('categoryName').value = category.categoryName;
    formGroup.control('categoryNameEn').value = category.categoryNameEn;
    formGroup.control('description').value = category.description;
    formGroup.control('active').value = category.active.toString();
  }

  static void initAddCategory({
    required WidgetRef ref,
  }) async {
    final formGroup = ref.read(categoryFormProvider).addCategoryForm..reset();
    formGroup.control('active').value = 'true';
  }
}
