import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:selivery_driver/core/services/cache_storage_services.dart';
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
      print('stutus code ${response.request}');
      if (response.statusCode == 200) {
        return right('تم رفع البيانات بنجاح');
      } else {
        return left('لم نتمكن من رفع البيانات');
      }
    } catch (error) {
      return left(error.toString());
    }
  }
}
