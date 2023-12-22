import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:selivery_driver/app/app.dart';
import 'package:selivery_driver/core/helper/notifictions_helper.dart';
import 'package:selivery_driver/firebase_options.dart';
import 'core/functions/location.dart';
import 'core/services/cache_storage_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  CacheStorageServices.init();

  requestPermissionLocation();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
 String ? tok = await FirebaseMessagingService.getDeviceToken();
  print("device token ${tok}");

  customErrorWidget();
  setupOrientation();

  runApp(const SeliveryDriver());
}
setupOrientation() {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
}
