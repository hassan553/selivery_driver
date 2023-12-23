import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:selivery_driver/binding.dart';
import '../core/rescourcs/app_theme.dart';
import '../features/home/views/main_view.dart';
<<<<<<< HEAD
import '../features/splash/presentation/splash.dart';
=======
>>>>>>> d977312fc639a58a4730d761a0630a69f8f77357

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
<<<<<<< HEAD
      home: SplashView(),
=======
      home: const  SplashView(),
>>>>>>> d977312fc639a58a4730d761a0630a69f8f77357
    );
  }
}
