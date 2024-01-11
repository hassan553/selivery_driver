import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/contants/api.dart';
import '../../../core/helper/notifictions_helper.dart';
import '../../../core/services/cache_storage_services.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn();

Future<Either<String, Unit>> handleSignInWithGoogle() async {
  try {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final result = await _loginWithGoogle(googleAuth.accessToken ?? '');
      result.fold((l) {
        return left(l);
      }, (r) {
        return right(unit);
      });
    }
    return right(unit);
  } catch (error) {
    return left(error.toString());
  }
}

Future<Either<String, String>> _loginWithGoogle(String idToken) async {
  try {
    var request = await http.post(driversGoogleSignIn,
        headers: authHeaders,
        body: json.encode({
          "idToken": idToken,
          'deviceToken': await FirebaseMessagingService.getDeviceToken()
        }));
    final result = json.decode(request.body);
    if (request.statusCode == 200) {
      await CacheStorageServices().setToken(result['token']);
      return right('result done');
    } else {
      throw ('لقد حدث خطا');
    }
  } catch (error) {
    throw ('لقد حدث خطا');
  }
}

googleLogOut() async {
  await _googleSignIn.signOut();
}
