import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:selivery_driver/core/widgets/custom_text.dart';

import '../../../../core/functions/global_function.dart';
import '../../../../core/rescourcs/app_colors.dart';
import '../../controller/driver_profile_controller.dart';
import '../../drivermodel.dart';

class UserInfo extends StatefulWidget {
  final DriverProfileModel? clientModel;
  const UserInfo({super.key, this.clientModel});

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  @override
  Widget build(BuildContext context) {
    DriverProfileController controller = Get.find();
    return Container(
      width: screenSize(context).width,
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(.7),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GetBuilder<DriverProfileController>(builder:
                (controller)=>CustomText(
              title: 'النوع : ${controller.driverProfileModel.driver!.gender}',
              fontSize: 16,
            ),),
            GetBuilder<DriverProfileController>(builder:
                (controller)=>CustomText(
              title: 'السن : ${controller.driverProfileModel.driver!.age}',
              fontSize: 16,
            ),),
            GetBuilder<DriverProfileController>(builder:
                (controller)=>CustomText(
              title: 'رقم الموبايل : ${controller.
              driverProfileModel.driver!.phone ?? "0114867777"} ',
              fontSize: 16,
            ),),
          ],
        ),
      ),
    );
  }
}
