import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:selivery_driver/binding.dart';
import 'package:selivery_driver/features/auth/presentation/views/car_info_view.dart';
import '../core/rescourcs/app_theme.dart';
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
      home:  const SplashView(),
    );
  }
}
