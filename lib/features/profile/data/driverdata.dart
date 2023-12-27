import 'package:selivery_driver/features/profile/data/driver_profile_model.dart';
import '../../../../core/contants/api.dart';
import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import '../../../core/services/cache_storage_services.dart';
import '../../../core/widgets/image_picker.dart';

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

  File? carImage;

  Future pickClientImage() async {
    carImage = await PickImage().pickImage();
    if (carImage != null) {
      await postDataWithFile(carImage!);
      await getDriverProfile();
    }
  }

  Future postDataWithFile(File image) async {
    try {
      var headers = {
        'Accept': 'application/json',
        "Authorization": 'Bearer ${CacheStorageServices().token}',
        "Content-Type": 'multipart/form-data',
      };

      var request = http.MultipartRequest("PATCH", profileUpdateImageUri);
      request.headers.addAll(headers);
      var fileExtension = image.path;

      var length = await image.length();
      var stream = http.ByteStream(image.openRead());

      var multipartFile =
          http.MultipartFile("image", stream, length, filename: image.path);
      request.files.add(multipartFile);

      var myrequest = await request.send();

      var response = await http.Response.fromStream(myrequest);
      final result = jsonDecode(response.body);
      print(result['message']);

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("tm");
        print(response.body);
      } else {
        throw Exception(result['message']);
      }
    } catch (error) {
      throw Exception(error.toString());
    }
  }
}
