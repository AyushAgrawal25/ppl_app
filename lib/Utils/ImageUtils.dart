import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImageUtils {
  Future<XFile?> getImage() async {
    try {
      final ImagePicker _picker = ImagePicker();
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image == null) {
        return null;
      }

      return image;
    } catch (err) {
      print(err);
      return null;
    }
  }

  Future getImageDataForWeb(File imgFile) async {
    try {} catch (err) {}
  }
}
