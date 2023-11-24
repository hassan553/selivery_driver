import 'package:selivery_driver/features/profile/data/driver_profile_model.dart';

import '../../../../core/class/crud.dart';

import '../../../../core/contants/api.dart';
import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import '../../../../../core/errors/failures.dart';
import '../../../../../core/widgets/image_picker.dart';
import '../../../core/services/cache_storage_services.dart';

class DriverData {
  Crud crud;
  DriverData(this.crud);
  getData() async {
    var response = await crud.getData(profileUri);
    return response.fold((left) => left, (right) => right);
  }

  updateData(String name, String phone, age) async {
    var response = await crud.updateData(profileUpdateInfoUriHZ, {
      "name": name,
      "phone": phone,
      "age": age,
      //"email":email,
    });
    return response.fold((left) => left, (right) => right);
  }
}

class DriverProfileRepo {
  Future<Either<String, DriverProfileModel>> getDriverProfile() async {
    try {
      DriverProfileModel clientProfileModel;
      final response = await http.get(
        Uri.parse(profileUri),
        headers: authHeadersWithToken(CacheStorageServices().token),
      );
      final result = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print(result);
        clientProfileModel = DriverProfileModel.fromJson(result['driver']);

        print(clientProfileModel);
        return Right(clientProfileModel);
      } else {
        print(result['message']);
        return Left(result['message']);
      }
    } catch (e) {
      print(e.toString());
      return Left(e.toString());
    }
  }

  Future<Either<String, DriverProfileModel>> updateClientProfileInfo({
    String? name,
    String? gender,
    String? phone,
    int? age,
  }) async {
    try {
      DriverProfileModel clientProfileModel;
      print('token${CacheStorageServices().token}');
      final response = await http.patch(
        profileUpdateInfoUri,
        body: jsonEncode(
            {'name': name, 'gender': gender, 'phone': phone, 'age': age}),
        headers: authHeadersWithToken(CacheStorageServices().token),
      );
      final result = jsonDecode(response.body);
      print(result['message']);

      if (response.statusCode == 200) {
        clientProfileModel = DriverProfileModel.fromJson(result['driver']);
        print(clientProfileModel);
        return Right(clientProfileModel);
      } else {
        return Left(result['message']);
      }
    } catch (e) {
      print(e.toString());
      return Left(e.toString());
    }
  }

  Future<Either<String, String>> updateDriverPassword(
      {required String newPassword, required String oldPassword}) async {
    try {
      final response = await http.patch(
        profileClientUpdatePassword,
        body: jsonEncode(
            {'oldPassword': oldPassword, 'newPassword': newPassword}),
        headers: authHeadersWithToken(CacheStorageServices().token),
      );
      final res = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print(res['message']);
        return const Right('لقد تم تغير كلمة السر بنجاح');
      } else {
        print(res['message']);

        return const Left('قم باعادة المحاوله');
      }
    } catch (e) {
      print(e.toString());
      return Left(e.toString());
    }
  }

  Future<Either<String, DriverProfileModel>> updateDriverProfileImage() async {
    try {
      DriverProfileModel driverProfileModel;

      final response = await http.patch(
        profileUpdateImageUri,
        body: jsonEncode({
          'image': '',
        }),
        headers: authHeadersWithToken(CacheStorageServices().token),
      );
      final result = jsonDecode(response.body);
      driverProfileModel = DriverProfileModel.fromJson(result['user']);
      print('profile body ${driverProfileModel.name}');
      if (response.statusCode == 200) {
        return Right(driverProfileModel);
      } else {
        return const Left('لقد حدث خطا ');
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  // File? carImage;

  // Future pickClientImage() async {
  //   try {
  //     carImage = await PickImage().pickImage();
  //     if (carImage != null) {
  //       await _uploadClientProfileImage(carImage!).then((value) {
  //       });
  //     }
  //   } catch (error) {
  //     print(error.toString());
  //   }
  // }

  // Future postDataWithFile(File image) async {
  //   try {
  //     var headers = {
  //       'Accept': 'application/json',
  //       "Authorization": 'Bearer ${CacheStorageServices().token}',
  //       "Content-Type": 'multipart/form-data',
  //     };

  //     var request = http.MultipartRequest(
  //         "PATCH", Uri.parse('http://192.168.1.122:8000/user/changePicture'));
  //     request.headers.addAll(headers);
  //     var fileExtension = image.path;

  //     var length = await image.length();
  //     var stream = http.ByteStream(image.openRead());

  //     var multipartFile =
  //         http.MultipartFile("image", stream, length, filename: image.path);
  //     request.files.add(multipartFile);

  //     var myrequest = await request.send();

  //     var response = await http.Response.fromStream(myrequest);
  //     Map responsebody = jsonDecode(response.body);
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       print("tm");
  //       print(response.body);
  //     } else {
  //       print(response.body);
  //     }
  //   } catch (error) {
  //     print(error.toString());
  //   }
  // }

  // Future<void> _uploadClientProfileImage(File? image) async {
  //   var headers = {
  //     'Accept': 'application/json',
  //     "Authorization": 'Bearer ${CacheStorageServices().token}',
  //     "Content-Type": 'multipart/form-data',
  //   };

  //   try {
  //     final formData = FormData.fromMap({
  //       'image': await MultipartFile.fromFile(
  //         image!.path,
  //         filename: 'image.jpg',
  //       ),
  //     });
  //     final response = await Dio().patch(
  //       'http://192.168.1.122:8000/user/changePicture',
  //       data: formData,
  //       options: Options(headers: headers),
  //     );
  //     if (response.statusCode == 200) {
  //       print('Image upload successful');
  //     } else {
  //       print('Image upload failed with status code: ${response.statusCode}');
  //       print(response.data); // You can print the response for debugging
  //     }
  //   } catch (error) {
  //     if (error is DioException) {
  //       print(error.message);
  //       print('Dio Error:');
  //       print(ServerFailure.serverFailure(
  //           error)); // You can print the response for debugging
  //     } else {
  //       print('Error: $error');
  //     }
  //   }
  // }

  // _uploadImage(String title, File file) async {
  //   try {
  //     var request = http.MultipartRequest('PATCH', profileUpdateImageUri);
  //     request.fields["images"] = title;
  //     request.files.add(http.MultipartFile.fromBytes(
  //       'image',
  //       File(file.path).readAsBytesSync(),
  //       filename: 'image.jpg',
  //     ));
  //     request.headers['Authorization'] =
  //         'Bearer ${CacheStorageServices().token}';
  //     request.headers['Content-Type'] = 'multipart/form-data';
  //     var res = await request.send();
  //     print('response ${res.toString()}');
  //     print('image upload success');
  //   } catch (error) {
  //     print(error.toString());
  //   }
  // }
}
