import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/functions/checkinternet.dart';
import '../../../core/widgets/snack_bar_widget.dart';
import '../data/driver_profile_model.dart';
import '../data/driverdata.dart';

class DriverProfileController extends GetxController {
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
        driverProfileModel = r;
      });
    } else {
      errorMessage = 'لا يوجد اتصال بالانترنت';
    }
    update();
  }

  bool changePassIsLoading = false;
  void changePassword(
      {required context,
      required String newPassword,
      required String oldPassord}) async {
    if (await checkInternet()) {
      changePassIsLoading = true;
      update();
      final result = await driverProfileRepo.updateDriverPassword(
          newPassword: newPassword, oldPassword: oldPassord);
      result.fold((l) {
        changePassIsLoading = false;
        showSnackBarWidget(
            context: context, message: l, requestStates: RequestStates.error);
      }, (r) {
        changePassIsLoading = false;
        showSnackBarWidget(
            context: context,
            message: 'تم التغير بنجاح',
            requestStates: RequestStates.success);
      });
    } else {
      showSnackBarWidget(
          context: context,
          message: 'لا يوجد اتصال بالانترنت',
          requestStates: RequestStates.error);
    }
    update();
  }

  bool updateProfileLoading = false;
  void updateProfile(
      {required context,
      required String name,
      required String phone,
      required String gender,
      required String age}) async {
    if (await checkInternet()) {
      updateProfileLoading = true;
      update();
      final result = await driverProfileRepo.updateClientProfileInfo(
          age: int.parse(age), gender: gender, name: name, phone: phone);
      result.fold((l) {
        updateProfileLoading = false;
        showSnackBarWidget(
            context: context, message: l, requestStates: RequestStates.error);
      }, (r) {
        updateProfileLoading = false;
        showSnackBarWidget(
            context: context,
            message: 'تم التغير بنجاح',
            requestStates: RequestStates.success);
      });
    } else {
      showSnackBarWidget(
          context: context,
          message: 'لا يوجد اتصال بالانترنت',
          requestStates: RequestStates.error);
    }
    update();
  }

  void setControllers() {
    name.text = driverProfileModel?.name ?? ' ';
    age.text = driverProfileModel?.age.toString() ?? '0';
    password.text ='********';
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
