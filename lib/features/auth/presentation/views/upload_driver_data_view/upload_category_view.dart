import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cubit/complete_car_info_cubit/complete_car_info_cubit.dart';
import '../../../../../core/functions/global_function.dart';
import '../../../../../core/rescourcs/app_colors.dart';
import '../../../../../core/widgets/custom_loading_widget.dart';
import '../../../../../core/widgets/custom_sized_box.dart';
import '../../../../../core/widgets/responsive_text.dart';
import '../../../../../core/widgets/snack_bar_widget.dart';
import '../../widgets/next_button.dart';
import '../../widgets/top_background_image.dart';

class UploadCategoryView extends StatefulWidget {
  const UploadCategoryView({super.key});

  @override
  State<UploadCategoryView> createState() => _UploadCategoryViewState();
}

class _UploadCategoryViewState extends State<UploadCategoryView> {
  TextEditingController modelController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String category = '';
  String categoryId = '';
  
  @override
  void dispose() {
    modelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: SingleChildScrollView(
              child: BlocConsumer<CompleteCarInfoCubit, CompleteCarInfoState>(
                listener: (context, state) {
                  if (CompleteCarInfoCubit.get(context).categories.isNotEmpty) {
                    category =
                        CompleteCarInfoCubit.get(context).categories[0]['name'];
                    categoryId =
                        CompleteCarInfoCubit.get(context).categories[0]['_id'];
                  }
                  if (state is CompleteCarInfoCategoryError) {
                    showSnackBarWidget(
                        context: context,
                        message: state.message,
                        requestStates: RequestStates.error);
                  }
                  if (state is CategoryErrorState) {
                    showSnackBarWidget(
                        context: context,
                        message: state.message,
                        requestStates: RequestStates.error);
                  }
                },
                builder: (context, state) {
                  return Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        topBackgroundImage(),
                        const CustomSizedBox(value: .1),
                        if (state is CompleteCarInfoCategoryLoading) ...[
                          const Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('يرجاء الانتطار '),
                                CustomLoadingWidget(),
                              ],
                            ),
                          )
                        ],
                        const CustomSizedBox(value: .1),
                        carInputFiledWidget(
                            context, 'نوع الموديل', modelController),
                        const CustomSizedBox(value: .05),
                        definedCarType(context,
                            CompleteCarInfoCubit.get(context).categories),
                        const CustomSizedBox(value: .05),
                        if (state is CategoryLoadingState||state is CompleteCarInfoCategoryLoading) ...[
                          CustomLoadingWidget(),
                        ] else ...[
                          carInfoButtonWidget(context, () {
                            if (formKey.currentState!.validate()) {
                              CompleteCarInfoCubit.get(context).uploadCategory(
                                  category: categoryId,
                                  model: modelController.text);
                            }
                          })
                        ],
                      ],
                    ),
                  );
                },
              ),
            ),
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

  Row definedCarType(BuildContext context, List items) {
    return Row(
      children: [
        const Expanded(
            child: ResponsiveText(text: 'تحديد نوع المركبة', scaleFactor: .05)),
        InkWell(
          onTap: () {
            showItemSelectionDialog(context, items);
          },
          child: Container(
            width: screenSize(context).width * .6,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.black),
            ),
            child: Row(
              children: [
                const Icon(Icons.arrow_drop_down_circle,
                    color: AppColors.black),
                const Spacer(),
                ResponsiveText(
                    text: category, scaleFactor: .04, color: AppColors.black),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Row carInputFiledWidget(
      BuildContext context, String text, TextEditingController controller) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ResponsiveText(text: text, scaleFactor: .05),
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
        validator: (String? value) {
          if (value == null) {
            return 'لا يسمح بقيمه فارغه';
          }
          return null;
        },
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(3),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColors.red),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColors.black),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColors.black),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColors.black),
          ),
        ),
      ),
    );
  }
}
