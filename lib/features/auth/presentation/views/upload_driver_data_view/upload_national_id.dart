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

class UploadNationalIdView extends StatelessWidget {
  const UploadNationalIdView({super.key});

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
                    return carInfoTakeImage(context, 'صورة البطاقة',
                        CompleteCarInfoCubit.get(context).nationalId, () {
                      showAlertDialog(
                          context,
                          (p0) => CompleteCarInfoCubit.get(context)
                              .pickNationalIdImage(p0));
                    });
                  },
                ),
                const CustomSizedBox(value: .05),
                BlocConsumer<CompleteCarInfoCubit, CompleteCarInfoState>(
                  listener: (context, state) {
                    if (state is NationalIdErrorState) {
                      showSnackBarWidget(
                          context: context,
                          message: state.message,
                          requestStates: RequestStates.error);
                    }
                    if (CompleteCarInfoCubit.get(context).nationalId == null) {
                      showSnackBarWidget(
                          context: context,
                          message: "قم بختيار صورة البطاقة",
                          requestStates: RequestStates.error);
                    }
                  },
                  builder: (context, state) {
                    return state is NationalIdLoadingState
                        ? const Center(
                            child: CircularProgressIndicator(
                                color: AppColors.primaryColor))
                        : carInfoButtonWidget(context, () {
                            if (CompleteCarInfoCubit.get(context).nationalId !=
                                null) {
                              CompleteCarInfoCubit.get(context)
                                  .uploadNationalId();
                            }
                          });
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
