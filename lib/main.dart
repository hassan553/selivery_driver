import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:selivery_driver/app/app.dart';
import 'package:selivery_driver/core/errors/widget_error.dart';
import 'package:selivery_driver/firebase_options.dart';
import 'core/functions/location.dart';
import 'core/helper/notifictions_helper.dart';
import 'core/services/cache_storage_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
//dart run flutter_native_splash:create
//dart run flutter_native_splash:create --path=flutter_native_splash.yaml
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  CacheStorageServices.init();
  requestPermissionLocation();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(
      FirebaseMessagingService.backgroundHandler);
  customErrorWidget();
  setupOrientation();
  runApp(const SeliveryDriver());
}

setupOrientation() {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
}
