import 'package:flutter/material.dart';
import '../../../../core/functions/global_function.dart';
import '../../../../core/rescourcs/app_colors.dart';
import '../../../../core/widgets/custom_text.dart';

SizedBox carInfoButtonWidget(BuildContext context, dynamic Function()? onTap) {
  return SizedBox(
    width: screenSize(context).width,
    child: MaterialButton(
      minWidth: double.infinity,
      height: 50,
      color: const Color(0xff014842),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      onPressed: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(
            title: 'التالي',
            fontSize: 25,
            color: Colors.white,
          ),
          const SizedBox(width: 20),
          Icon(Icons.arrow_forward, color: AppColors.white),
        ],
      ),
    ),
  );
}
