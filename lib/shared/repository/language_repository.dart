import 'package:nvc_cinemas/shared/constants/store_key.dart';
import 'package:nvc_cinemas/shared/util/platform_type.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LanguageRepositoryProtocol {
  Future<void> remove();

  Future<void> saveLanguage(String language);

  Future<String?> fetchLanguage();
}

final languageRepositoryProvider = Provider<LanguageRepository>((ref) {
  return LanguageRepository(ref.read);
});

class LanguageRepository implements LanguageRepositoryProtocol {
  LanguageRepository(this._reader);

  late final PlatformType _platform = _reader(platformTypeProvider);
  final Reader _reader;
  String? _language;

  @override
  Future<void> remove() async {
    _language = null;
    final prefs = await SharedPreferences.getInstance();

    if (_platform == PlatformType.iOS ||
        _platform == PlatformType.android ||
        _platform == PlatformType.linux) {
      const storage = FlutterSecureStorage();
      try {
        await storage.delete(key: StoreKey.language.toString());
      } on Exception {}
    } else {
      await prefs.remove(StoreKey.language.toString());
    }

    // await prefs.remove(StoreKey.user.toString());
  }

  @override
  Future<void> saveLanguage(String language) async {
    final prefs = await SharedPreferences.getInstance();
    _language = language;
    if (_platform == PlatformType.iOS ||
        _platform == PlatformType.android ||
        _platform == PlatformType.linux) {
      const storage = FlutterSecureStorage();
      try {
        await storage.write(
          key: StoreKey.language.toString(),
          value: language,
        );
      } on Exception {}
    } else {
      await prefs.setString(StoreKey.language.toString(), language);
    }
  }

  @override
  Future<String?> fetchLanguage() async {
    // if (_language != null) {
    //   return _language;
    // }

    String? languageValue;

    if (_platform == PlatformType.iOS ||
        _platform == PlatformType.android ||
        _platform == PlatformType.linux) {
      const storage = FlutterSecureStorage();
      languageValue = await storage.read(key: StoreKey.language.toString());
    } else {
      final prefs = await SharedPreferences.getInstance();
      languageValue = prefs.getString(StoreKey.language.toString());
    }
    try {
      _language = languageValue ?? 'vi';
    } on Exception {
      return _language;
    }

    return _language;
  }
}
