import 'package:flutter/material.dart';
import 'package:selivery_driver/app/app.dart';
import 'core/services/cache_storage_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  CacheStorageServices.init();
  runApp(const SeliveryDriver());
}
