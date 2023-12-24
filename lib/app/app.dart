import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:selivery_driver/binding.dart';
import 'package:selivery_driver/features/auth/forget_password/view/otp_view.dart';
import '../core/functions/google_sign.dart';
import '../core/rescourcs/app_theme.dart';
import '../features/auth/date/social_auth.dart';
import '../features/auth/verify_email/views/otp_view.dart';
import '../features/home/views/main_view.dart';
import '../features/splash/presentation/splash.dart';

class SeliveryDriver extends StatelessWidget {
  const SeliveryDriver({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: MyBinding(),
      title: 'Selivery ',
      theme: appTheme(),
      textDirection: TextDirection.rtl,
      home:  SplashView(),
    );
  }
}

class Texst extends StatelessWidget {
  const Texst({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Title'),
      ),
      body: Center(
        child: Column(
          children: [
            TextButton(
              onPressed: () async {
                await handleSignInWithGoogle();
              },
              child: const Text(
                "Text Button",
              ),
            ),
            const SizedBox(height: 30),
            TextButton(
              onPressed: () {
                googleLogOut();
              },
              child: const Text(
                "logout",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
