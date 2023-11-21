import 'package:flutter/material.dart';
import 'package:selivery_driver/app/app.dart';
import 'core/services/cache_storage_services.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  CacheStorageServices.init();
  Firebase.initializeApp();
  runApp(const SeliveryDriver());
}
