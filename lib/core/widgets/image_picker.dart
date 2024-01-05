import 'dart:io';

import 'package:image_picker/image_picker.dart';

class PickImage {
  Future<File?> pickImage([bool isCamera=false]) async {
    File pickedImage;
    try {
      final imagePicker = ImagePicker();
      final pickedImage0 =
          await imagePicker.pickImage(source:isCamera?ImageSource.camera: ImageSource.gallery);

      if (pickedImage0 != null) {
        pickedImage = File(pickedImage0.path);
        return pickedImage;
      }
    } catch (error) {}
    return null;
  }

  // final ImagePicker _picker = ImagePicker();
  // ImagePicker get picker => _picker;
  // XFile? pickedImage;
  // Future<void> pickImage(ImageSource source) async {
  //   try {
  //     XFile? image = await _picker.pickImage(source: source);
  //     if (image != null) {
  //       pickedImage = image;
  //     }
  //   } catch (e) {
  //     print("Error picking image: $e");
  //   }
  // }
}
