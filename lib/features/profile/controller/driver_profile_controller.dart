import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/functions/checkinternet.dart';
import '../../../core/widgets/snack_bar_widget.dart';
import '../data/driver_profile_model.dart';
import '../data/driver_data.dart';

class DriverProfileController extends GetxController {
  DriverProfileRepo driverProfileRepo = DriverProfileRepo();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController ageController = TextEditingController(text: '0');
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
        errorMessage = '';
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
      required String oldPassword}) async {
    if (await checkInternet()) {
      changePassIsLoading = true;
      update();
      final result = await driverProfileRepo.updateDriverPassword(
          newPassword: newPassword, oldPassword: oldPassword);
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
        getDriverProfile();
      });
    } else {
      showSnackBarWidget(
          context: context,
          message: 'لا يوجد اتصال بالانترنت',
          requestStates: RequestStates.error);
    }
    update();
  }

  bool changeImageLoding = false;
  changePicture(context) async {
    if (await checkInternet()) {
      try {
        changeImageLoding = true;
        update();
        await driverProfileRepo.pickClientImage();
        getDriverProfile();
        changeImageLoding = false;
      } catch (error) {
        changeImageLoding = false;
      }
    } else {
      showSnackBarWidget(
          context: context,
          message: 'لا يوجد اتصال بالانترنت',
          requestStates: RequestStates.error);
    }
    update();
  }

  void setControllers() {
    try {
      nameController.text = driverProfileModel?.name ?? '';
      ageController.text = driverProfileModel?.age.toString() ?? '';
      password.text = '********';
      phoneController.text = driverProfileModel?.phone ?? '';
      genderController.text = driverProfileModel?.gender ?? '';
      update();
    } catch (error) {}
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
    nameController.dispose();
    genderController.dispose();
    phoneController.dispose();
    password.dispose();
    super.dispose();
  }
}
