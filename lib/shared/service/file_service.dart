import 'dart:io';

import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class FileService {
  static Future<String> pickImage() async {
    var path = '';
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return '';

      print('Path: ${image.path}');
      final imageTemporary = File(image.path);
      path = image.path;
      return image.path;
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }

    return path;
  }
}
