import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/addcarforrent.dart';
import '../../../../core/functions/global_function.dart';
import '../../../../core/rescourcs/app_colors.dart';
import '../../../../core/widgets/custom_appBar.dart';
import '../../../../core/widgets/custom_image.dart';
import '../../../../core/widgets/responsive_text.dart';
import '../../widgets/rental_buy_car_add_image.dart';
import '../../widgets/rental_buy_car_form_widget.dart';

class RentalCarFormView extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController faceLinkController = TextEditingController();
  TextEditingController telController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController driverController = TextEditingController();
  TextEditingController requirmentController = TextEditingController();
  final String catId;
  RentalCarFormView({super.key, required this.catId});

  @override
  Widget build(BuildContext context) {
    Get.put(AddCarForRentController());
    print("id rent $catId");
    return Scaffold(
      appBar: customAppBar(context),
      body: GetBuilder<AddCarForRentController>(builder:
          (controller)=>Container(
        width: screenSize(context).width,
        height: screenSize(context).height,
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              AppColors.white.withOpacity(.5),
              AppColors.primaryColor,
              AppColors.primaryColor,
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              BuyRentalCarFormWidget(title: 'الاسم',controller: nameController,),
              const SizedBox(height: 10),
              BuyRentalCarFormWidget(title: 'رقم الموبايل',controller: phoneController,),
              const SizedBox(height: 10),
              BuyRentalCarFormWidget(title: 'لينك الفيس بوك',controller: faceLinkController,),
              const SizedBox(height: 10),
              BuyRentalCarFormWidget(title: 'لينك التليجرام',controller: telController,),
              const SizedBox(height: 10),
              BuyRentalCarFormWidget(title: 'سعر السياره',controller: priceController,),
              const SizedBox(height: 10),
              BuyRentalCarFormWidget(title: 'طلبات الايجار',controller:requirmentController ,),
              const SizedBox(height: 10),
              BuyRentalCarFormWidget(title: 'اسم السياره',controller: typeController,),
              const SizedBox(height: 10),
              BuyRentalCarFormWidget(title: 'تفاصيل السياره',controller: descController,),
              const SizedBox(height: 10),
              Text("ايجار السيارة بسائق ادخل رقم1 بدون سائق ادخل 0"),
              const SizedBox(height: 10),
              BuyRentalCarFormWidget(title: 'سائق',controller: driverController,),
              const SizedBox(height: 10),
              //RentalBuyCarAddImageWidget(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const FittedBox(
                    child: ResponsiveText(
                      text: 'صور السياره',
                      scaleFactor: .05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
<<<<<<< HEAD
                  Container(
                    width: screenSize(context).width * .6,
                    //height: screenSize(context).height * .15,
                    padding:const  EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.black),
                    ),
                    child:  const Column(
                      mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                          ResponsiveText(
                            text: '1-',
                            scaleFactor: .05,
                            fontWeight: FontWeight.bold,
                          ),
                          ResponsiveText(
                            text: '2-',
                            scaleFactor: .05,
                            fontWeight: FontWeight.bold,
                          ),
                          ResponsiveText(
                            text: '3-',
                            scaleFactor: .05,
                            fontWeight: FontWeight.bold,
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: CircleAvatar(
                              backgroundColor: Colors.blue,
                              child: ResponsiveText(
                                text: '+',
                                scaleFactor: .05,
                                fontWeight: FontWeight.bold,
                                color: AppColors.white,
                              ),
                            ),
                          )
                        ]),
=======
                  InkWell(
                      onTap: () async {
                        await controller.uploadfile();
                      },
                      child: Container(
                        width: screenSize(context).width * .6,
                        height: screenSize(context).height * .12,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child:
                        GetBuilder<AddCarForRentController>
                          (builder: (controller)=>controller.file
                            == null ?
                        CustomAssetsImage(path:'assets/add_image.png')
                            : Image.file(controller.file!),),)
>>>>>>> c7463fe8ab49235c670f6d8b7a4e4981616bacff
                  ),

                ],
              ),
              SizedBox(height: 10),
              MaterialButton(onPressed: (){
                controller.addCarData(nameController.text,
                    phoneController.text,
                    faceLinkController.text,
                    telController.text,
                    priceController.text,
                    requirmentController.text,
                    typeController.text,
                    descController.text,
                    driverController.text,
                    catId);
              },child: Text("Add"),),

            ],
          ),
        ),
      ),),
    );
  }
}
