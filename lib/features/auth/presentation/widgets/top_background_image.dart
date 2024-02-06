import 'package:flutter/material.dart';

import '../../../../core/rescourcs/app_colors.dart';
import '../../../../core/widgets/build_rich_text.dart';
import '../../../../core/widgets/custom_image.dart';

Widget topBackgroundImage() {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Align(
          alignment: Alignment.center,
          child: CustomAssetsImage(path: 'assets/Young man ordering taxi.png')),
      const Center(
          child: CustomRichText(
        color: AppColors.primaryColor,
        imagePath: 'assets/image.png',
      )),
    ],
  );
}
