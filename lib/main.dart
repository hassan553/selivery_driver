import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:selivery_driver/app/app.dart';
import 'package:selivery_driver/core/errors/widget_error.dart';
import 'package:selivery_driver/core/helper/notifictions_helper.dart';
import 'package:selivery_driver/firebase_options.dart';
import 'core/functions/location.dart';
import 'core/services/cache_storage_services.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  CacheStorageServices.init();
  requestPermissionLocation();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  String? tok = await FirebaseMessagingService.getDeviceToken();
  customErrorWidget();
  setupOrientation();
  await Firebase.initializeApp(options:
  DefaultFirebaseOptions.currentPlatform);
  runApp(const SeliveryDriver());
}

setupOrientation() {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
}
