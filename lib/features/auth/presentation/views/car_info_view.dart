import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/functions/global_function.dart';
import '../../../../../core/widgets/custom_image.dart';
import '../../../../../core/widgets/custom_sized_box.dart';
import '../../../../../core/widgets/image_picker.dart';
import '../../cubit/complete_car_info_cubit/complete_car_info_cubit.dart';
import '../../date/car_info_repo.dart';

import '../../../../../core/rescourcs/app_colors.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/responsive_text.dart';

class CompleteCarInfoView extends StatelessWidget {
  TextEditingController? controller;
  CompleteCarInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: BlocProvider(
        create: (context) => CompleteCarInfoCubit(CarInfoRepo(), PickImage()),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomSizedBox(value: .02),
                Align(
                    alignment: Alignment.center,
                    child: CustomAssetsImage(path: 'assets/logo.png')),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child:
                      BlocBuilder<CompleteCarInfoCubit, CompleteCarInfoState>(
                    builder: (context, state) {
                      var cubit = CompleteCarInfoCubit.get(context);
                      return Column(
                        children: [
                          const CustomSizedBox(value: .01),
                          const CustomSizedBox(value: .01),
                          const CustomSizedBox(value: .01),
                          carInfoTakeImage(
                              context,
                              'صورة الرخصة',
                              cubit.driverLicense,
                              cubit.pickDriverLicenseImage),
                          const CustomSizedBox(value: .01),
                          carInfoTakeImage(
                              context,
                              'صورة رخصة المركبة',
                              cubit.carLicense,
                              cubit.pickDriverCarLicenseImage),
                          const CustomSizedBox(value: .01),
                          carInfoTakeImage(context, 'صورة المركبة',
                              cubit.carImage, cubit.pickCarImage),
                          const CustomSizedBox(value: .01),
                          carInfoTakeImage(context, 'صورة البطاقة',
                              cubit.nationalId, cubit.pickIationalIdImage),
                          const CustomSizedBox(value: .03),
                          carInfoButtonWidget(context),
                          const CustomSizedBox(value: .01),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row definedCarType(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: ResponsiveText(
            text: 'تحديد نوع المركبة',
            scaleFactor: .05,
          ),
        ),
        Container(
          width: screenSize(context).width * .6,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.white),
          ),
          child: const Row(
            children: [
              Icon(
                Icons.arrow_drop_down_circle,
                color: AppColors.white,
              ),
              Spacer(),
              ResponsiveText(
                text: '  سياره',
                scaleFactor: .04,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Row carInfoTakeImage(
      BuildContext context, String title,
      File? file, void Function()? ontap) {
    return Row(
      children: [
        Expanded(
          child: ResponsiveText(
            text: title,
            scaleFactor: .05,
          ),
        ),
        InkWell(
          onTap: ontap,
          child: Container(
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(15)),
            width: screenSize(context).width * .6,
            height: 80,
            child: file == null
                ? CustomAssetsImage(path: 'assets/add_image.png')
                : ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.file(
                      file,
                      fit: BoxFit.fill,
                    ),
                  ),
          ),
        ),
      ],
    );
  }

  SizedBox carInfoButtonWidget(BuildContext context) {
    return SizedBox(
      width: screenSize(context).width * .4,
      child: CustomButton(
        function: () {
          CompleteCarInfoCubit.get(context).completeCarInfo(context);
        },
        title: 'انشاء',
        fontSize: 25,
        color: const Color(0xff014842),
      ),
    );
  }

  Row carInputFiledWidget(
      BuildContext context, String text, TextEditingController controller) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ResponsiveText(
              text: text,
              scaleFactor: .05,
            ),
          ),
          const SizedBox(width: 10),
          customCarInfoTextFiledWidget(context, controller),
        ]);
  }

  Widget customCarInfoTextFiledWidget(
      BuildContext context, TextEditingController controller) {
    return SizedBox(
      width: screenSize(context).width * .6,
      height: 40,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(3),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Color(0xff014842)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: AppColors.white),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: AppColors.white),
          ),
        ),
      ),
    );
  }
}
