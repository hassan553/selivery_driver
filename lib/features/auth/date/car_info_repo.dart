import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:selivery_driver/core/services/cache_storage_services.dart';
import '../../../../core/contants/api.dart';
import '../../../../core/widgets/image_picker.dart';

class CarInfoRepo {
  void hassan({
    required File carImage,
    required File nationalId,
    required File carLicense,
    required File driverLicense,
    required String model,
  }) async {
    try {
      var headers = {'Authorization': 'Bearer ${CacheStorageServices().token}'};
      var request = http.MultipartRequest('POST', completeCarInfoUrl);
      request.fields.addAll({
        'category': '6553bc4b524c058dcc993aa3',
        'model': 'Toyota Crolla 2008'
      });

      request.files
          .add(await http.MultipartFile.fromPath('carImages', carImage.path));
      request.files.add(
          await http.MultipartFile.fromPath('nationalId', nationalId.path));
      request.files.add(
          await http.MultipartFile.fromPath('carLicense', carLicense.path));
      request.files.add(await http.MultipartFile.fromPath(
          'driverLicense', driverLicense.path));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
        print('done');
      } else {
        print(response.reasonPhrase);
        print(response.statusCode);
        print('error');
        print(CacheStorageServices().token);
      }
    } catch (error) {
      print(error.toString());
    }
  }

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

  Future postDataWithFiles(List<File> images) async {
    try {
      var headers = {
        'Accept': 'application/json',
        "Authorization": 'Bearer ${CacheStorageServices().token}',
        "Content-Type": 'multipart/form-data',
      };

      var request = http.MultipartRequest(
          "POST", Uri.parse('http://192.168.1.122:8000/user/changePicture'));
      request.headers.addAll(headers);

      for (var image in images) {
        var length = await image.length();
        var stream = http.ByteStream(image.openRead());

        var multipartFile = http.MultipartFile(
          "images[]", // Use an array-like name to denote multiple images
          stream,
          length,
          filename: 'image.jpg', // Set the filename with the desired image type
        );
        request.files.add(multipartFile);
      }

      var myrequest = await request.send();

      var response = await http.Response.fromStream(myrequest);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("tm");
        print(response.body);
      } else {
        print(response.body);
      }
    } catch (error) {
      print(error.toString());
    }
  }

  upload(String title, File file) async {
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse('http://192.168.1.122:8000/request'));
      request.fields["carLicense"] = title;
      request.files.add(http.MultipartFile.fromBytes(
          'carLicense', File(file.path).readAsBytesSync(),
          filename: file.path));
      request.headers['Authorization'] =
          'Bearer ${CacheStorageServices().token}';
      request.headers['Content-Type'] = 'multipart/form-data';
      var res = await request.send();
      print(res.statusCode);
      if (res.statusCode == 200) {
        print('response ${res.toString()}');
        print('image upload success');
      } else {}
    } catch (error) {
      print(error.toString());
    }
  }

  Future<void> uploadImages(File? files) async {
    if (files != null) {
      try {
        var request = http.MultipartRequest(
            'POST', Uri.parse('http://192.168.1.122:8000/request'));

        request.fields['model'] = 'model';
        request.fields['category'] = '64f4b0fa8edeed76b547e935';
        request.headers['Authorization'] =
            'Bearer ${CacheStorageServices().token}';
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
        print(res.statusCode);
        if (res.statusCode == 200) {
          print('image upload success');
        } else {
          print('image upload failed');
        }
      } catch (error) {
        print(error.toString());
      }
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
      String url = '${baseUri}request';

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
            'Authorization': 'Bearer ${CacheStorageServices().token}',
            'Content-Type': "multipart/form-data",
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
