import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../views/home_view.dart';

class HomeController extends GetxController {
  int bottomNavigationCurrentIndex = 0;
  void changeBottomNavigationCurrentIndex(int index) {
    bottomNavigationCurrentIndex = index;
    update();
  }
}
