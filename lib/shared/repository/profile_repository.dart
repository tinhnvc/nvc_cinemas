// import 'dart:convert';
// import 'dart:io';
//
// import 'package:nvc_cinemas/shared/constants/store_key.dart';
// import 'package:nvc_cinemas/shared/model/profile.dart';
// import 'package:nvc_cinemas/shared/util/platform_type.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// abstract class ProfileRepositoryProtocol {
//   Future<void> remove();
//
//   Future<void> saveProfile(Profile profile);
//
//   Future<Profile?> fetchProfile();
// }
//
// class ProfileRepository implements ProfileRepositoryProtocol {
//   ProfileRepository();
//
//   Profile? _profile;
//
//   @override
//   Future<void> remove() async {
//     _profile = null;
//     final prefs = await SharedPreferences.getInstance();
//
//     if (Platform.isIOS || Platform.isAndroid || Platform.isLinux) {
//       const storage = FlutterSecureStorage();
//       try {
//         await storage.delete(key: StoreKey.profile.toString());
//       } on Exception catch (e) {}
//     } else {
//       await prefs.remove(StoreKey.profile.toString());
//     }
//   }
//
//   @override
//   Future<void> saveProfile(Profile profile) async {
//     final prefs = await SharedPreferences.getInstance();
//     _profile = profile;
//     if (Platform.isIOS || Platform.isAndroid || Platform.isLinux) {
//       const storage = FlutterSecureStorage();
//       try {
//         await storage.write(
//           key: StoreKey.profile.toString(),
//           value: json.encode(profile.toJson()),
//         );
//       } on Exception catch (e) {}
//     } else {
//       await prefs.setString(
//         StoreKey.profile.toString(),
//         json.encode(profile.toJson()),
//       );
//     }
//   }
//
//   @override
//   Future<Profile?> fetchProfile() async {
//     // if (_profile != null) {
//     //   return _profile;
//     // }
//
//     String? profileValue;
//
//     if (Platform.isIOS || Platform.isAndroid || Platform.isLinux) {
//       const storage = FlutterSecureStorage();
//       profileValue = await storage.read(key: StoreKey.profile.toString());
//     } else {
//       final prefs = await SharedPreferences.getInstance();
//       profileValue = prefs.getString(StoreKey.profile.toString());
//     }
//     try {
//       if (profileValue != null) {
//         _profile =
//             profileFromJson(json.decode(profileValue) as Map<String, dynamic>);
//       }
//     } on Exception catch (e) {
//       return _profile;
//     }
//
//     return _profile;
//   }
// }
