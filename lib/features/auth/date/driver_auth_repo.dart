import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import '../../../../core/contants/api.dart';
import '../../../core/helper/notifictions_helper.dart';
import '../../../core/services/cache_storage_services.dart';

class DriverAuthRepo {
  Future<Either<String, String>> driverLoginRepo(
      String email, String password) async {
    try {
      final response = await http.post(
        driverLogin,
        body: jsonEncode({
          'email': email,
          'password': password,
          "deviceToken": await FirebaseMessagingService.getDeviceToken()
        }),
        headers: authHeaders,
      );
      final result = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (result['message'] == 'LoggedIn successfully') {
          await CacheStorageServices().setToken(result['token']);
          await CacheStorageServices().setId(result['driver']['_id']);
          await CacheStorageServices()
              .setDate(result['driver']['subscription_expiry']);
        }
        return Right(result['message']);
      } else {
        return Left(result['message']);
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, String>> driverRegisterRepo(
      String name, String email, String password) async {
    try {
      final response = await http.post(
        driverRegister,
        body: jsonEncode({
          'email': email,
          'password': password,
          'name': name,
          'gender': 'male',
          'age': 25,
          'phone': '01000000000',
          'deviceToken': await FirebaseMessagingService.getDeviceToken(),
        }),
        headers: authHeaders,
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
  }
}
