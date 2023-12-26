import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

requestPermissionLocation() async {
  try {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Get.snackbar("تنبية", "قم بتفعيل الموقع");
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Get.snackbar("تنبية", "لرجاء اعطاء صلاحية الموقع للتطبيق");
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Get.snackbar("تنبية", "لايمكنك استخدام التطبيق من دون الموقع");
    }
  } on PlatformException catch (error) {
    print('error ${error.toString()}');
  } catch (error) {
    print('error ${error.toString()}');
  }
}
