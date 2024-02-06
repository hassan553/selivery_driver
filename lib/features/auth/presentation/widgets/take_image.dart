import 'dart:io';
import 'package:flutter/material.dart';
import '../../../../core/functions/global_function.dart';
import '../../../../core/widgets/custom_image.dart';
import '../../../../core/widgets/responsive_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/complete_car_info_cubit/complete_car_info_cubit.dart';
Row carInfoTakeImage(
    BuildContext context, String title, File? file, void Function()? onTap) {
  return Row(
    children: [
      Expanded(
        child: ResponsiveText(
          text: title,
          scaleFactor: .05,
        ),
      ),
      InkWell(
        onTap: onTap,
        child:  Container(
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 1, 54, 50),
                  borderRadius: BorderRadius.circular(10)),
              width: screenSize(context).width * .6,
              height: 80,
              child: BlocBuilder<CompleteCarInfoCubit, CompleteCarInfoState>(
              builder: (context, state)=> file == null
                  ? CustomAssetsImage(path: 'assets/add_image.png')
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.file(file, fit: BoxFit.fill),
                    ),),
            ),
          
        
      ),
    ],
  );
}
