import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:dartz/dartz.dart';
import '../../../core/contants/api.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn();

Future<Either<String, Unit>> handleSignInWithGoogle() async {
  try {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    print('email ${googleUser?.email.toString()}');
    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      print('token ${googleAuth.accessToken}');
      final result = await v(googleAuth.accessToken ?? '');
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

Future<Either<String, String>> v(String idToken) async {
  try {
    print('ooo$idToken');
    var request = await http.post(driverGoogleSignIn,
        headers: authHeaders,
        body: json.encode({"idToken": idToken, 'deviceToken': '1212'}));

    if (request.statusCode == 200) {
      print(request.body.toString());
      return right('result done');
    } else {
      return left(request.body.toString());
    }
  } catch (error) {
    return left(error.toString());
  }
}

googleLogOut() async {
  await _googleSignIn.signOut();
}
