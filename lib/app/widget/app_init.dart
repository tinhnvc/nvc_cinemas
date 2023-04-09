import 'dart:async';
import 'dart:io';

import 'package:nvc_cinemas/gen/assets.gen.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:nvc_cinemas/shared/repository/token_repository.dart';
import 'package:nvc_cinemas/shared/util/fcm/fcm_util.dart';
import 'package:nvc_cinemas/shared/util/fcm/notification_service.dart';
import 'package:nvc_cinemas/shared/widget/snack_bar_support.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppInit extends ConsumerStatefulWidget {
  const AppInit({Key? key}) : super(key: key);

  @override
  _AppInitState createState() => _AppInitState();
}

class _AppInitState extends ConsumerState<AppInit> with WidgetsBindingObserver {
  // final _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  late final NotificationService notificationService;

  @override
  void initState() {
    super.initState();
    // Check foreground/background
    WidgetsBinding.instance.addObserver(this);

    // Firebase setup
    NotificationService.initialize();
    _initBackgroundMode();
    _setupInteractedMessage();

    // Check connectivity
    _initConnectivity();
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen(
          _updateConnectionStatus,
        );
  }

  @override
  void dispose() {
    // WidgetsBinding.instance.removeObserver(this);
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> _initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException {
      return;
    }

    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      SnackBarSupport.connectivityStatus(context: context, result: result);
    });
  }

  @override
  Widget build(BuildContext context) {
    NotificationService.initialize();
    Future.delayed(
      const Duration(seconds: 3),
      () => _init(context, ref),
    );

    return Scaffold(
      backgroundColor: ColorName.pageBackground,
      body: SafeArea(
        child: Center(
          child: Container(
            child: Assets.images.logoPng.image(width: 250, fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }

  Future<void> _setupInteractedMessage() async {
    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  Future<void> _init(BuildContext context, WidgetRef ref) async {
    final fcmToken = await getDeviceToken();
    print('FCM/APNS TOKEN: $fcmToken');
    await FcmTokenRepository().saveFcmToken(fcmToken ?? '');
    // final currentLanguage =
    //     await ref.watch(languageRepositoryProvider).fetchLanguage();
    // ref.read(languageProvider.notifier).update(currentLanguage ?? 'vi');

    await ref.read(tokenRepositoryProvider).fetchToken().then((token) {
      if (token != null) {
        // ref.read(profileProvider.notifier).fetchProfile();
        // InitUtil.initApp(ref);
        Navigator.pushReplacementNamed(context, '/home-page');
      } else {
        Navigator.pushNamedAndRemoveUntil(
            context, '/sign-in', (Route<dynamic> route) => false);
      }
    });
  }
}

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  // handle action
  print('Background mode');
  print(notificationResponse.payload);
  print(notificationResponse.notificationResponseType);
}

// Future<void> _initForegroundMode() async {}

Future<void> _initBackgroundMode() async {
  // both platform
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  // iOS Platform
  if (Platform.isIOS) {
    final messaging = FirebaseMessaging.instance;

    await messaging.requestPermission();
  }
}

void _handleMessage(RemoteMessage message) {
  print('Message log: ${message.data}');
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(
  RemoteMessage message,
) async {
  await Firebase.initializeApp();
  print('Handling a background message: ${message.data}');
  // await ProfileRepository().fetchProfile().then((value) {});
}
