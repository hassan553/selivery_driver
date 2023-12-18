import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:selivery_driver/core/services/cache_storage_services.dart';
import '../../../../core/functions/get_token.dart';
import '../../../../core/contants/api.dart';
import '../../../../core/widgets/image_picker.dart';

class CarInfoRepo {
  File? carImage;

  Future<File?> pickDriverCompleteCarInfoImage() async {
    try {
      carImage = await PickImage().pickImage();
      if (carImage != null) {
        return carImage;
      }
    } catch (error) {
      print(error.toString());
    }
    return carImage;
  }

  _uploadImage(String title, File file) async {
    try {
      var request = http.MultipartRequest('POST',
          Uri.parse("http://192.168.1.5:8000/request"));
      request.fields["carLicense"] = title;
      request.files.add(http.MultipartFile.fromBytes(
          'image', File(file.path).readAsBytesSync(),
          filename: file.path));
      request.headers['Authorization'] = 'Bearer ${CacheStorageServices().token}';
      request.headers['Content-Type'] = 'multipart/form-data';
      var res = await request.send();
      if (res.statusCode == 200) {
        print('response ${res.toString()}');
        print('image upload success');
      } else {}
    } catch (error) {
      print(error.toString());
    }
  }

  Future<void> uploadImages(File files) async {
    try {
      var request = http.MultipartRequest('POST', profileUpdateImageUri);
      request.fields['model'] = 'model';
      request.fields['category'] = '64f4b0fa8edeed76b547e935';
      request.headers['Authorization'] = 'Bearer ${CacheStorageServices().token}';
      request.headers['Content-Type'] = 'multipart/form-data';
      request.files.add(http.MultipartFile(
        'carImages', // Field name for car image
        carImage!.readAsBytes().asStream(),

        carImage!.lengthSync(),
        filename: carImage!.path.split('/').last,
      ));

      request.files.add(http.MultipartFile(
        'nationalId', // Field name for driver image
        carImage!.readAsBytes().asStream(),
        carImage!.lengthSync(),
        filename: carImage!.path.split('/').last,
      ));

      request.files.add(http.MultipartFile(
        'carLicense', // Field name for car image
        carImage!.readAsBytes().asStream(),

        carImage!.lengthSync(),
        filename: carImage!.path.split('/').last,
      ));

      request.files.add(http.MultipartFile(
        'driverLicense', // Field name for driver image
        carImage!.readAsBytes().asStream(),
        carImage!.lengthSync(),
        filename: carImage!.path.split('/').last,
      ));
      var res = await request.send();
      if (res.statusCode == 200) {
        print('image upload success');
      } else {
        print('image upload failed');
      }
    } catch (error) {
      print(error.toString());
    }
  }

  //try this code
  Future uploadImage({
    required File carImage,
    required File nationalId,
    required File carLicense,
    required File driverLicense,
    required String model,
  }) async {
    try {
      String url = 'http://192.168.1.5:8000/request';
      FormData formData = FormData.fromMap({
        'carImages': await MultipartFile.fromFile(
          carImage.path,
          filename: 'image.jpg',
        ),
        'nationalId': await MultipartFile.fromFile(
          nationalId.path,
          filename: 'image.jpg',
        ),
        'carLicense': await MultipartFile.fromFile(
          carLicense.path,
          filename: 'image.jpg',
        ),
        'driverLicense': await MultipartFile.fromFile(
          driverLicense.path,
          filename: 'image.jpg',
        ),
        'Category': '6504e2eee1ec5cf383d77e24',
        'model': "car",
      });
      Response response = await Dio().post(
        url,
        data: formData,
        options: Options(
            headers: {
              'Authorization':'Bearer ${CacheStorageServices().token}',
              'Content-Type':"multipart/form-data",
            },
        ),
      );
       print(response.statusCode);
       print(response.data);
      if (response.statusCode == 200) {
        print('Image uploaded successfully');
      } else {
        print('Image upload failed with status code ${response.statusCode}');
      }
    } catch (e) {
      print('Error uploading image: ${e.toString()}');
    }
  }

  Future uploadImages2({
    required File carImage,
    required File nationalId,
    required File carLicense,
    required File driverLicense,
    required String model,
  }) async {
    try {
      String url = 'http://192.168.1.5:8000/request';
      FormData formData = FormData();

      // Add car images
        formData.files.add(MapEntry(
          'carImage',
          await MultipartFile.fromFile(
            carImage.path,
            filename: 'car_image.jpg',
          ),
        ));

      // Add other files
      formData.files.addAll([
        MapEntry(
          'nationalId',
          await MultipartFile.fromFile(
            nationalId.path,
            filename: 'national_id.jpg',
          ),
        ),
        MapEntry(
          'carLicense',
          await MultipartFile.fromFile(
            carLicense.path,
            filename: 'car_license.jpg',
          ),
        ),
        MapEntry(
          'driverLicense',
          await MultipartFile.fromFile(
            driverLicense.path,
            filename: 'driver_license.jpg',
          ),
        ),
      ]);

      // Add other form data
      // formData.fields.addAll({
      //   'Category': '6504e2eee1ec5cf383d77e24',
      //   'model': model,
      // });
      var mapEntries = {
        'Category': '6504e2eee1ec5cf383d77e24',
        'model': "toyota",
      }.entries.toList();

      formData.fields.addAll(mapEntries);

      Response response = await Dio().post(
        url,
        data: formData,
        options: Options(
          headers: {'Authorization': 'Bearer ${CacheStorageServices().token}'},
        ),
      );

      print(response.statusCode);
      print(response.data);

      if (response.statusCode == 200) {
        print('Images uploaded successfully');
      } else {
        print('Images upload failed with status code ${response.statusCode}');
      }
    } catch (e) {
      print('Error uploading images: $e');
    }
  }
}
