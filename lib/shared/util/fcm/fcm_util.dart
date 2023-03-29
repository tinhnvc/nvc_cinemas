import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:safe_device/safe_device.dart';

Future<String?> getDeviceToken() async {
  await FirebaseMessaging.instance.requestPermission();

  if (Platform.isIOS) {
    // check real device
    final isRealDevice = await SafeDevice.isRealDevice;
    final fcmKey = isRealDevice
        ? await FirebaseMessaging.instance.getAPNSToken()
        : await FirebaseMessaging.instance.getToken();
    return fcmKey!.toLowerCase();
  }
  final fcmKey = await FirebaseMessaging.instance.getToken();

  return fcmKey;
}

Future<Map<String, dynamic>> getDeviceInfo() async {
  if (Platform.isIOS) {
    final deviceData = _readIosDeviceInfo(await DeviceInfoPlugin().iosInfo);
    print(deviceData);

    return deviceData;
  }
  final deviceData =
      _readAndroidBuildData(await DeviceInfoPlugin().androidInfo);
  print(deviceData);

  return deviceData;
}

Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
  return <String, dynamic>{
    'name': data.name,
    'systemName': data.systemName,
    'systemVersion': data.systemVersion,
    'model': data.model,
    'localizedModel': data.localizedModel,
    'identifierForVendor': data.identifierForVendor,
    'isPhysicalDevice': data.isPhysicalDevice,
    'utsname.sysname:': data.utsname.sysname,
    'utsname.nodename:': data.utsname.nodename,
    'utsname.release:': data.utsname.release,
    'utsname.version:': data.utsname.version,
    'utsname.machine:': data.utsname.machine,
  };
}

Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
  return <String, dynamic>{
    'version.securityPatch': build.version.securityPatch,
    'version.sdkInt': build.version.sdkInt,
    'version.release': build.version.release,
    'version.previewSdkInt': build.version.previewSdkInt,
    'version.incremental': build.version.incremental,
    'version.codename': build.version.codename,
    'version.baseOS': build.version.baseOS,
    'board': build.board,
    'bootloader': build.bootloader,
    'brand': build.brand,
    'device': build.device,
    'display': build.display,
    'fingerprint': build.fingerprint,
    'hardware': build.hardware,
    'host': build.host,
    'id': build.id,
    'manufacturer': build.manufacturer,
    'model': build.model,
    'product': build.product,
    'supported32BitAbis': build.supported32BitAbis,
    'supported64BitAbis': build.supported64BitAbis,
    'supportedAbis': build.supportedAbis,
    'tags': build.tags,
    'type': build.type,
    'isPhysicalDevice': build.isPhysicalDevice,
    'systemFeatures': build.systemFeatures,
    'displaySizeInches':
        ((build.displayMetrics.sizeInches * 10).roundToDouble() / 10),
    'displayWidthPixels': build.displayMetrics.widthPx,
    'displayWidthInches': build.displayMetrics.widthInches,
    'displayHeightPixels': build.displayMetrics.heightPx,
    'displayHeightInches': build.displayMetrics.heightInches,
    'displayXDpi': build.displayMetrics.xDpi,
    'displayYDpi': build.displayMetrics.yDpi,
    'serialNumber': build.serialNumber,
  };
}

String getUa(Map<String, dynamic> deviceInfo) {
  var deviceUa = 'Dart 2.17.6';
  if (Platform.isIOS) {
    deviceUa = 'NVC Cinemas '
        '${deviceInfo['name']} '
        '${deviceInfo['systemName']} ${deviceInfo['systemVersion']} '
        'CFNetwork/${deviceInfo['utsname.release:']} '
        'Darwin/${deviceInfo['utsname.release:']}';
  }
  if (Platform.isAndroid) {
    deviceUa = 'NVC Cinemas Dalvik/2.1.0 (Linux; U; '
        'Android ${deviceInfo['version.release']}; '
        '${deviceInfo['brand'].toString().toUpperCase()} '
        '${deviceInfo['device'].toString().toUpperCase()} '
        'Darwin/${deviceInfo['product']})';
  }

  return deviceUa;
}
