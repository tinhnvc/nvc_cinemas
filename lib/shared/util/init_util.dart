import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/feature/auth/provider/auth_provider.dart';
import 'package:nvc_cinemas/feature/movie/provider/movie_rating_provider.dart';
import 'package:nvc_cinemas/shared/provider/util_provider.dart';
import 'package:nvc_cinemas/shared/repository/language_repository.dart';

import '../../feature/movie/provider/day_of_week_provder.dart';

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
}
