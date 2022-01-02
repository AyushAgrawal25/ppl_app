import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImageUtils {
  Future<File?> getImage() async {
    try {
      final ImagePicker _picker = ImagePicker();
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image == null) {
        return null;
      }
      return File(image.path);
    } catch (err) {
      print(err);
      return null;
    }
  }
}
