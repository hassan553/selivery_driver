import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:selivery_driver/binding.dart';
import 'package:selivery_driver/core/widgets/image_picker.dart';
import 'package:selivery_driver/features/auth/cubit/complete_car_info_cubit/complete_car_info_cubit.dart';
import 'package:selivery_driver/features/auth/presentation/views/upload_driver_data_view/welcome_view.dart';
import '../core/rescourcs/app_theme.dart';
import '../features/home/views/main_view.dart';
import '../features/auth/date/car_info_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../features/splash/presentation/splash.dart';
import '../features/text.dart';

class SeliveryDriver extends StatelessWidget {
  const SeliveryDriver({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CompleteCarInfoCubit(CarInfoRepo(),PickImage())..getCategoryData()..getStep(),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialBinding: MyBinding(),
        title: 'Selivery سائق',
        theme: appTheme(),
        textDirection: TextDirection.rtl,
        home: const MainView(),
      ),
    );
  }
}
