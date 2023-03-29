import 'dart:developer';
// import 'dart:io';

import 'package:nvc_cinemas/app/app.dart';
import 'package:nvc_cinemas/shared/util/logger.dart';
import 'package:nvc_cinemas/shared/util/platform_type.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> start() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // HttpOverrides.global = MyHttpOverrides();

  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  final platformType = detectPlatformType();
  runApp(
    ProviderScope(
      overrides: [
        platformTypeProvider.overrideWithValue(platformType),
      ],
      observers: [Logger()],
      child: const App(),
    ),
  );
}
