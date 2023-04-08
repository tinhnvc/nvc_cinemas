import 'package:flutter_riverpod/flutter_riverpod.dart';

final languageProvider = StateNotifierProvider<LanguageNotifier, String>(
  (ref) => LanguageNotifier(),
);

class LanguageNotifier extends StateNotifier<String> {
  LanguageNotifier() : super('vi');

  void update(String value) {
    state = value;
  }
}

final appLanguage = StateNotifierProvider((ref) => AppLanguage());

class AppLanguage extends StateNotifier<bool> {
  AppLanguage() : super(false);
  // true - vi
  // false - en
  set changed(bool value) => state = value;
}
