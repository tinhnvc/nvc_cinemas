import 'dart:io';

import 'package:nvc_cinemas/shared/util/platform_type.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nvc_cinemas/shared/constants/store_key.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class TokenRepositoryProtocol {
  Future<void> remove();

  Future<void> saveToken(String token);

  Future<String?> fetchToken();
}

final tokenRepositoryProvider = Provider<TokenRepository>((ref) {
  return TokenRepository(ref.read);
});

class TokenRepository implements TokenRepositoryProtocol {
  TokenRepository(this._reader);

  late final PlatformType _platform = _reader(platformTypeProvider);
  final Reader _reader;
  String? _token;

  @override
  Future<void> remove() async {
    _token = null;
    final prefs = await SharedPreferences.getInstance();

    if (_platform == PlatformType.iOS ||
        _platform == PlatformType.android ||
        _platform == PlatformType.linux) {
      const storage = FlutterSecureStorage();
      try {
        await storage.delete(key: StoreKey.token.toString());
      } on Exception {}
    } else {
      await prefs.remove(StoreKey.token.toString());
    }

    await prefs.remove(StoreKey.user.toString());
  }

  @override
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    _token = token;
    if (_platform == PlatformType.iOS ||
        _platform == PlatformType.android ||
        _platform == PlatformType.linux) {
      const storage = FlutterSecureStorage();
      try {
        await storage.write(
          key: StoreKey.token.toString(),
          value: token,
        );
      } on Exception {}
    } else {
      await prefs.setString(StoreKey.token.toString(), token);
    }
  }

  @override
  Future<String?> fetchToken() async {
    // if (_token != null) {
    //   return _token;
    // }

    String? tokenValue;

    if (_platform == PlatformType.iOS ||
        _platform == PlatformType.android ||
        _platform == PlatformType.linux) {
      const storage = FlutterSecureStorage();
      tokenValue = await storage.read(key: StoreKey.token.toString());
    } else {
      final prefs = await SharedPreferences.getInstance();
      tokenValue = prefs.getString(StoreKey.token.toString());
    }
    try {
      if (tokenValue != null) {
        _token = tokenValue;
      }
    } on Exception {
      return _token;
    }

    return _token;
  }
}

abstract class FcmTokenRepositoryProtocol {
  Future<void> remove();

  Future<void> saveFcmToken(String fcmToken);

  Future<String?> fetchFcmToken();
}

class FcmTokenRepository implements FcmTokenRepositoryProtocol {
  FcmTokenRepository();

  String? _fcmToken;

  @override
  Future<void> remove() async {
    _fcmToken = null;
    final prefs = await SharedPreferences.getInstance();

    if (Platform.isIOS || Platform.isAndroid || Platform.isLinux) {
      const storage = FlutterSecureStorage();
      try {
        await storage.delete(key: StoreKey.fcmToken.toString());
      } on Exception {}
    } else {
      await prefs.remove(StoreKey.fcmToken.toString());
    }
  }

  @override
  Future<void> saveFcmToken(String fcmToken) async {
    final prefs = await SharedPreferences.getInstance();
    _fcmToken = fcmToken;
    if (Platform.isIOS || Platform.isAndroid || Platform.isLinux) {
      const storage = FlutterSecureStorage();
      try {
        await storage.write(
          key: StoreKey.fcmToken.toString(),
          value: fcmToken,
        );
      } on Exception {}
    } else {
      await prefs.setString(
        StoreKey.fcmToken.toString(),
        fcmToken,
      );
    }
  }

  @override
  Future<String?> fetchFcmToken() async {
    String? fcmTokenValue;

    if (Platform.isIOS || Platform.isAndroid || Platform.isLinux) {
      const storage = FlutterSecureStorage();
      fcmTokenValue = await storage.read(key: StoreKey.fcmToken.toString());
    } else {
      final prefs = await SharedPreferences.getInstance();
      fcmTokenValue = prefs.getString(StoreKey.fcmToken.toString());
    }
    try {
      if (fcmTokenValue != null) {
        _fcmToken = fcmTokenValue;
      }
    } on Exception {
      return _fcmToken;
    }

    return _fcmToken;
  }
}
