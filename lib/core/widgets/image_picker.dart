import 'dart:io';
import 'package:image_picker/image_picker.dart';

class PickImage {
  Future<File?> pickImage([bool isCamera = false]) async {
    File pickedImage;
    try {
      final imagePicker = ImagePicker();
      final pickedImage0 = await imagePicker.pickImage(
          source: isCamera ? ImageSource.camera : ImageSource.gallery,
          imageQuality: 80);

      if (pickedImage0 != null) {
        pickedImage = File(pickedImage0.path);
        return pickedImage;
      }
    } catch (error) {}
    return null;
  }

}
