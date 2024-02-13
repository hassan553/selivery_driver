import 'package:flutter/material.dart';
import '../../../cubit/complete_car_info_cubit/complete_car_info_cubit.dart';

import '../../../../../core/rescourcs/app_colors.dart';
import '../../../../../core/widgets/custom_sized_box.dart';
import '../../../../../core/widgets/snack_bar_widget.dart';
import '../../widgets/next_button.dart';
import '../../widgets/sow_dailog.dart';
import '../../widgets/take_image.dart';
import '../../widgets/top_background_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UploadCarLicenseView extends StatelessWidget {
  const UploadCarLicenseView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                topBackgroundImage(),
                const CustomSizedBox(value: .05),
                BlocBuilder<CompleteCarInfoCubit, CompleteCarInfoState>(
                  builder: (context, state) {
                    return carInfoTakeImage(
                        context,
                        'صورة رخصة المركبة',
                        CompleteCarInfoCubit.get(context).carLicense,
                       () {
                      showAlertDialog(
                          context,
                          (p0) => CompleteCarInfoCubit.get(context)
                              .pickDriverCarLicenseImage(p0));
                    });
                  },
                ),
                const CustomSizedBox(value: .05),
                BlocConsumer<CompleteCarInfoCubit, CompleteCarInfoState>(
                  listener: (context, state) {
                    if (state is CarLicenseErrorState) {
                      showSnackBarWidget(
                          context: context,
                          message: state.message,
                          requestStates: RequestStates.success);
                    }
                     if (CompleteCarInfoCubit.get(context).carImage == null) {
                      showSnackBarWidget(
                          context: context,
                          message: "قم بتحديد صورة رخصة المركبة",
                          requestStates: RequestStates.success);
                    }
                  },
                  builder: (context, state) {
                    return state is CarLicenseLoadingState
                        ? const Center(
                            child: CircularProgressIndicator(
                                color: AppColors.primaryColor))
                        : carInfoButtonWidget(context, () {
                            if (CompleteCarInfoCubit.get(context).carLicense !=
                                null) {
                              CompleteCarInfoCubit.get(context)
                                  .uploadCarLicenseImage();
                            }
                          });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
