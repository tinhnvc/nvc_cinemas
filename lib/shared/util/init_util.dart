import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/feature/auth/provider/auth_provider.dart';
import 'package:nvc_cinemas/shared/provider/util_provider.dart';
import 'package:nvc_cinemas/shared/repository/language_repository.dart';

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
}
