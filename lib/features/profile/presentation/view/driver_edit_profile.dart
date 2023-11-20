import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/driver_profile_controller.dart';
import '../../../../../core/widgets/custom_appBar.dart';
import '../../../../../core/widgets/custom_image.dart';

import '../../../../../core/functions/global_function.dart';
import '../../../../../core/rescourcs/app_colors.dart';
import '../../../../../core/widgets/custom_sized_box.dart';
import '../../../../../core/widgets/custom_text.dart';

class DriverEditProfileView extends StatefulWidget {
  const DriverEditProfileView({super.key});

  @override
  State<DriverEditProfileView> createState() => _DriverEditProfileViewState();
}

class _DriverEditProfileViewState extends State<DriverEditProfileView> {
  final TextEditingController nameController =TextEditingController();
  final TextEditingController phoneController =TextEditingController();
  final TextEditingController ageController =TextEditingController();
  final TextEditingController emailController =TextEditingController();
  final TextEditingController passwordController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    DriverProfileController controller = Get.find();
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
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        child: CustomAssetsImage(path: 'assets/person.png'),
                      ),
                      Icon(
                        Icons.edit,
                        color: AppColors.black.withOpacity(.7),
                      ),
                    ],
                  ),
                  editTextFiled('الاسم',
                      "${controller.driverProfileModel.driver!.name}",
                      nameController),
                  editTextFiled('رقم الموبايل',
                      "${controller.driverProfileModel.driver!.phone??
                          "0113456778"}",
                      phoneController),
                  editTextFiled('السن', "${controller.driverProfileModel.driver!.age}",ageController),
                  editTextFiled('البريد الالكتروني', "${controller.driverProfileModel.driver!.email}",
                      emailController),
                  editTextFiled('كلمة السر', "......",passwordController),
                ],
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
              builder: (controller)=>Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: MaterialButton(
              onPressed: () {
                // navigateTo(const DriverEditProfileView());
               // controller.updateData(nameController.text,
               //     phoneController.text,
               //     ageController.text);
                 print("pl");
              },
              height: 50,
              minWidth: 80,
              color: AppColors.primaryColor,
              child: const Text(
                'تحديث',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          )),
        ],
      ),
    );
  }

  Widget editTextFiled(String prefix, String hint,textcontroller) {
    return TextField(
      controller: textcontroller,
      cursorColor: AppColors.black,
      decoration: InputDecoration(
        //prefixText: prefix,
        //labelText: prefix,
        hintText: hint,
        prefixIcon: Icon(
              Icons.edit,
              size: 20,
              color: AppColors.black.withOpacity(.7),
            ),
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.black)),
      ),
    );
  }
}
