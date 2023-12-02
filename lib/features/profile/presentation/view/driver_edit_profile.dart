import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:selivery_driver/features/profile/presentation/widgets/custom_textfield.dart';
import 'package:selivery_driver/features/profile/presentation/widgets/selecte_gender.dart';
import '../../../../core/widgets/custom_loading_widget.dart';
import '../../controller/driver_profile_controller.dart';
import '../../../../../core/widgets/custom_appBar.dart';
import '../../../../../core/widgets/custom_image.dart';

import '../../../../../core/functions/global_function.dart';
import '../../../../../core/rescourcs/app_colors.dart';
import '../../../../../core/widgets/custom_sized_box.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../widgets/change_password_widget.dart';

class DriverEditProfileView extends StatefulWidget {
  const DriverEditProfileView({super.key});

  @override
  State<DriverEditProfileView> createState() => _DriverEditProfileViewState();
}

class _DriverEditProfileViewState extends State<DriverEditProfileView> {
  final formKey = GlobalKey<FormState>();
  DriverProfileController controller = Get.find();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.setControllers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(.7),
              borderRadius: BorderRadius.circular(8),
            ),
            child: GetBuilder<DriverProfileController>(
              builder: (controller) => Padding(
                padding: const EdgeInsets.all(8),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (controller.changeImageLoding) ...[
                        const SizedBox(height: 20),
                        const LinearProgressIndicator(
                            color: Colors.green, backgroundColor: Colors.red),
                        const SizedBox(height: 20),
                      ],
                      Stack(
                        alignment: Alignment.bottomLeft,
                        children: [
                          SizedBox(
                            width: 150,
                            height: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CustomNetworkImage(
                                imagePath:
                                    controller.driverProfileModel?.image ?? '',
                                boxFit: BoxFit.fill,
                              ),
                            ), // Replace with your image path
                          ),
                          InkWell(
                            onTap: () {
                              controller.changePicture(context);
                            },
                            child: CircleAvatar(
                              backgroundColor: AppColors.primaryColor,
                              child: Icon(
                                Icons.edit,
                                color: AppColors.black.withOpacity(.7),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      EditField(
                          validate: (p0) {
                            if (p0 == null) {
                              return 'لا يسمح بقيمه فارغه';
                            } else if (p0.isEmpty) {
                              return 'لا يسمح بقيمه فارغه';
                            }
                            return null;
                          },
                          prefix: 'الاسم',
                          hint: controller.nameController),
                      const SizedBox(height: 15),
                      InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return const MyDialog();
                              },
                            );
                          },
                          child: EditField(
                              prefix: 'كلمة المرور',
                              hint: TextEditingController(text: '*****'),
                              isEnable: false)),
                      const SizedBox(height: 15),
                      EditField(
                          validate: (p0) {
                            if (p0 == null) {
                              return 'لا يسمح بقيمه فارغه';
                            } else if (p0.isEmpty) {
                              return 'لا يسمح بقيمه فارغه';
                            } else if (p0.length != 11) {
                              return 'ادخل رقم صحيح';
                            }
                            return null;
                          },
                          type: TextInputType.phone,
                          prefix: 'رقم الموبايل',
                          hint: controller.phoneController),
                      const SizedBox(height: 15),
                      EditField(
                          validate: (p0) {
                            int p = 0;
                            if (p0 != null) {
                              if (p0.isNotEmpty) {
                                p = int.parse(p0);
                              }
                            }
                            if (p0 == null) {
                              return 'لا يسمح بقيمه فارغه';
                            } else if (p < 21) {
                              return 'العمر يجب ان يزيد عن 21 عاما';
                            } else if (p > 100) {
                              return 'ادخل رقم صحيح';
                            } else if (p0.isEmpty) {
                              return 'لا يسمح بقيمه فارغه';
                            }
                            return null;
                          },
                          type: TextInputType.number,
                          prefix: 'السن',
                          hint: controller.ageController),
                      const SizedBox(height: 15),
                      InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return const SelecteGenderWidget();
                            },
                          );
                        },
                        child: EditField(
                            prefix: 'النوع',
                            isEnable: false,
                            hint: controller.genderController),
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const CustomSizedBox(value: .01),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomText(
                      title: 'نوع السيارة',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    CustomText(
                      title: 'Kia cerato',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
                const Spacer(),
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.primaryColor)),
                      child: CustomAssetsImage(
                        path: 'assets/car.png',
                        height: 70,
                        width: screenSize(context).width * .6,
                        boxFit: BoxFit.fill,
                      ),
                    ),
                    Positioned(
                      bottom: 5,
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        child: const Text('تغير الصوره'),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          const CustomSizedBox(value: .01),
          const CustomSizedBox(value: .03),
          GetBuilder<DriverProfileController>(
            builder: (controller) {
              return controller.updateProfileLoading
                  ? const CustomLoadingWidget()
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: MaterialButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            controller.updateProfile(
                                context: context,
                                age: controller.ageController.text,
                                gender: controller.genderController.text,
                                name: controller.nameController.text,
                                phone: controller.phoneController.text);
                          }
                        },
                        height: 50,
                        minWidth: 80,
                        color: AppColors.primaryColor,
                        child: const Text(
                          'تحديث',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
            },
          ),
        ],
      ),
    );
  }
}
