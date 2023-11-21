
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/functions/checkinternet.dart';
import '../data/driver_profile_model.dart';
import '../data/driverdata.dart';

class DriverProfileController extends GetxController{
  DriverProfileRepo driverProfileRepo = DriverProfileRepo();
  final TextEditingController gander = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController age = TextEditingController(text: '0');
  final TextEditingController password = TextEditingController();

  bool isLoading = false;
  String errorMessage = '';
  DriverProfileModel? driverProfileModel;
  void getDriverProfile() async {
    if (await checkInternet()) {
      isLoading = true;
      update();
      final result = await driverProfileRepo.getDriverProfile();
      result.fold((l) {
        isLoading = false;
        errorMessage = l;
      }, (r) {
        isLoading = false;
        driverProfileModel = r ;
      });
    } else {
      errorMessage = 'لا يوجد اتصال بالانترنت';
    }
    update();
  }
    void setControllers() {
    name.text = driverProfileModel?.name ?? ' ';
    age.text = driverProfileModel?.age.toString() ?? '0';
    password.text = driverProfileModel?.password ?? ' ';
    phone.text = driverProfileModel?.phone ?? ' ';
    gander.text = driverProfileModel?.gander ?? ' ';
  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getDriverProfile();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    name.dispose();
    gander.dispose();
    phone.dispose();
    password.dispose();
    super.dispose();
  }

}