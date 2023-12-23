import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:selivery_driver/core/services/cache_storage_services.dart';
import '../../../../../core/contants/api.dart';
import '../../../../../core/contants/strings.dart';

import '../../../../../main.dart';

class VerifyDriverEmailAddressRepo {
  Future<Either<String, String>> driverVerifyEmailCode(
      String email, String verificationCode) async {
    try {
      final response = await http.post(
        verifyDriverEmailCodeUrl,
        body:
            jsonEncode({'email': email, 'verificationCode': verificationCode}),
        headers: authHeaders,
      );
      final result = jsonDecode(response.body);
      if (response.statusCode == 200) {
        await CacheStorageServices().setToken(result['token']);
        await CacheStorageServices().setId(result['driver']['_id']);
        return Right(result['message']);
      } else {
        return Left(result['message']);
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, String>> clientResendEmailCode(String email) async {
    try {
      final response = await http.post(
        verifyClientResendEmailCodeUrl,
        body: jsonEncode({'email': email}),
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
