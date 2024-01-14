import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selivery_driver/core/widgets/custom_loading_widget.dart';
import '../../../../../core/functions/global_function.dart';
import '../../../../../core/widgets/custom_image.dart';
import '../../../../../core/widgets/custom_sized_box.dart';
import '../../../../../core/widgets/image_picker.dart';
import '../../../../controllers/categoriescontroller.dart';
import '../../../../core/widgets/snack_bar_widget.dart';
import '../../../home/views/main_view.dart';
import '../../cubit/complete_car_info_cubit/complete_car_info_cubit.dart';
import '../../date/car_info_repo.dart';
import '../../../../../core/rescourcs/app_colors.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/responsive_text.dart';
import 'package:get/get.dart';

class CompleteCarInfoView extends StatefulWidget {
  const CompleteCarInfoView({super.key});

  @override
  State<CompleteCarInfoView> createState() => _CompleteCarInfoViewState();
}

class _CompleteCarInfoViewState extends State<CompleteCarInfoView> {
  TextEditingController controller = TextEditingController();
  TextEditingController modelController = TextEditingController();
  String category = '';
  String categoryId = '';

  @override
  void dispose() {
    controller.dispose();
    modelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: BlocProvider(
        create: (context) =>
            CompleteCarInfoCubit(CarInfoRepo(), PickImage())..getCategoryData(),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocConsumer<CompleteCarInfoCubit, CompleteCarInfoState>(
                  listener: (context, state) {
                    if (state is CompleteCarInfoCategorySuccess) {
                      if (CompleteCarInfoCubit.get(context)
                          .categories
                          .isNotEmpty) {
                        category = CompleteCarInfoCubit.get(context)
                            .categories[0]['name'];
                        categoryId = CompleteCarInfoCubit.get(context)
                            .categories[0]['_id'];
                      }
                    }
                    if (state is CompleteCarInfoSuccess) {
                      showSnackBarWidget(
                          context: context,
                          message: state.message,
                          requestStates: RequestStates.success);
                      navigateOff(const MainView());
                    }
                    if (state is CompleteCarInfoError) {
                      showSnackBarWidget(
                          context: context,
                          message: state.message,
                          requestStates: RequestStates.error);
                    }
                    if (state is CompleteCarInfoEmptyImage) {
                      showSnackBarWidget(
                          context: context,
                          message: "قم بدخال حقل الصور",
                          requestStates: RequestStates.error);
                    }
                  },
                  builder: (context, state) {
                    return state is CompleteCarInfoCategoryLoading
                        ? const Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('يرجا الانتطار '),
                                CustomLoadingWidget(),
                              ],
                            ),
                          )
                        : Container();
                  },
                ),
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
                          const CustomSizedBox(value: .02),
                          carInputFiledWidget(
                              context, 'نوع الموديل', modelController),
                          const CustomSizedBox(value: .01),
                          definedCarType(context, cubit.categories),
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

  Row definedCarType(BuildContext context, List items) {
    return Row(
      children: [
        const Expanded(
          child: ResponsiveText(
            text: 'تحديد نوع المركبة',
            scaleFactor: .05,
          ),
        ),
        InkWell(
          onTap: () {
            showItemSelectionDialog(context, items);
          },
          child: Container(
            width: screenSize(context).width * .6,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.white),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.arrow_drop_down_circle,
                  color: AppColors.white,
                ),
                const Spacer(),
                ResponsiveText(
                  text: category,
                  scaleFactor: .04,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Row carInfoTakeImage(
      BuildContext context, String title, File? file, void Function()? ontap) {
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
      width: screenSize(context).width * .8,
      child: BlocBuilder<CompleteCarInfoCubit, CompleteCarInfoState>(
        builder: (context, state) {
          return state is CompleteCarInfoLoading
              ? const Center(
                  child: CircularProgressIndicator(color: AppColors.white))
              : CustomButton(
                  function: () {
                    CompleteCarInfoCubit.get(context).takeImages(
                        category: categoryId, model: modelController.text);
                  },
                  title: 'انشاء',
                  fontSize: 25,
                  color: const Color(0xff014842),
                );
        },
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

  void showItemSelectionDialog(BuildContext context, List items) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('قم بختيار القسم'),
          content: SizedBox(
            height: 200,
            child: SingleChildScrollView(
              child: ListBody(
                children: List.generate(
                    items.length,
                    (index) => _buildListItem(
                        context, items[index]['name'], items[index]['_id'])),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildListItem(BuildContext context, String itemName, String id) {
    return ListTile(
      title: Text(itemName),
      onTap: () {
        setState(() {
          category = itemName;
          categoryId = id;
          
        });
        Navigator.of(context).pop(); 
      },
    );
  }
}
