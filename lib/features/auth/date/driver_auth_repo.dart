import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import '../../../../core/contants/strings.dart';
import '../../../../core/contants/api.dart';
import '../../../../main.dart';
import '../../../core/helper/notifictions_helper.dart';
import '../../../core/services/cache_storage_services.dart';

class DriverAuthRepo {
  Future<Either<String, String>> driverLoginRepo(
      String email, String password) async {
    try {
      final response = await http.post(
        driverLogin,
        body: jsonEncode(
            {'email': email, 'password': password,
              'deviceToken': await FirebaseMessagingService.getDeviceToken()}),
        headers: authHeaders,
      );
      final result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (result['message'] == 'LoggedIn successfully') {
          print(response.body);
          await CacheStorageServices().setToken(result['token']);
          await CacheStorageServices().setId(result['driver']['_id']);
          await CacheStorageServices().setDate(result['driver']['subscription_expiry']);
          print( CacheStorageServices().date);
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
          'age': 22,
          'phone': '01092607114',
          'deviceToken': await FirebaseMessagingService.getDeviceToken(),
        }),
        headers: authHeaders,
      );
      final result = jsonDecode(response.body);

      if (response.statusCode == 200) {

        return Right(result['message']);
      } else {
        return Left(result['message']);
      }
    } catch (e) {
      return Left(e.toString());
    }
  }
}
