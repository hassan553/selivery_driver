import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:dartz/dartz.dart';
import '../../../core/contants/api.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
    final response = jsonDecode(request.body);
    if (request.statusCode == 200) {
      print(request.body.toString());
      return right('result done');
    } else {
      print(response['message']);
      return left(request.body.toString());
    }
  } catch (error) {
    print(error.toString());
    return left(error.toString());
  }
}

googleLogOut() async {
  await _googleSignIn.signOut();
  print('done logout');
}

Future<UserCredential> signInWithGoogleH() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );
  print('cccc$credential');
  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}
