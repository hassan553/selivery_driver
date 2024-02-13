import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../../core/functions/checkinternet.dart';
import '../../../core/services/cache_storage_services.dart';
import '../../../../core/contants/api.dart';
import 'package:dartz/dartz.dart';

class CarInfoRepo {
  Future<Either<String, String>> uploadImages({
    required File carImage,
    required File nationalId,
    required File carLicense,
    required File driverLicense,
    required String model,
    required String category,
  }) async {
    try {
      var headers = {'Authorization': 'Bearer ${CacheStorageServices().token}'};
      var request = http.MultipartRequest('POST', completeCarInfoUrl);
      request.fields.addAll({'category': category, 'model': model});
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
      final r = await response.stream.bytesToString();
     
      if (response.statusCode == 200 || response.statusCode == 201) {
        return right('تم رفع البيانات بنجاح');
      } else {
        return left('لم نتمكن من رفع البيانات');
      }
    } catch (error) {
      return left(error.toString());
    }
  }

  Future<Either<String, String>> uploadImage(
      {required File image, required Uri uri, required String title}) async {
    if (await checkInternet()) {
      try {
       
        var headers = {
          'Accept': 'application/json',
          "Authorization": 'Bearer ${CacheStorageServices().token}',
          "Content-Type": 'multipart/form-data',
        };

        var request = http.MultipartRequest("POST", uri);
        request.headers.addAll(headers);
        var fileExtension = image.path;

        var length = await image.length();
        var stream = http.ByteStream(image.openRead());

        var multipartFile =
            http.MultipartFile(title, stream, length, filename: image.path);
        request.files.add(multipartFile);

        var myrequest = await request.send();

        var response = await http.Response.fromStream(myrequest);
        final result = jsonDecode(response.body);
       
        if (response.statusCode == 200 || response.statusCode == 201) {
          return right(result['message']);
        } else {
          return left(result['message']);
        }
      } catch (error) {
        
        return left(error.toString());
      }
    } else {
      return left("لا يوجد اتصال بالانترنت");
    }
  }

  Future<Either<String, String>> uploadCategory(
      String category, String model) async {
    if (await checkInternet()) {
      try {
        final response = await http.post(
          openRequestUri,
          body: jsonEncode({'category': category, 'model': model}),
          headers: authHeadersWithToken(CacheStorageServices().token),
        );
        final result = jsonDecode(response.body);
        
        if (response.statusCode == 200 || response.statusCode == 201) {
          return Right(result['message']);
        } else {
          return Left(result['message']);
        }
      } catch (e) {
      
        return Left(e.toString());
      }
    } else {
      return left("لا يوجد اتصال بالانترنت");
    }
  }

  Future<Either<String, String>> getStep() async {
    if (await checkInternet()) {
      try {
        final response = await http.get(
          openRequestUri,
          headers: authHeadersWithToken(CacheStorageServices().token),
        );
        final result = jsonDecode(response.body);
       
        if (response.statusCode == 200 || response.statusCode == 201) {
          String? res = result['request'][0]['_id'];
          return Right(res ?? '');
        } else {
          return Left(result['message']);
        }
      } catch (e) {
       
        return Left(e.toString());
      }
    } else {
      return left("لا يوجد اتصال بالانترنت");
    }
  }
}
