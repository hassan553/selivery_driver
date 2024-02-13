import 'package:flutter/material.dart';
import '../../../../../core/functions/global_function.dart';
import '../../../../../core/rescourcs/app_colors.dart';
import 'upload_category_view.dart';

import '../../widgets/next_button.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: screenSize(context).width,
        height: screenSize(context).height,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill, image: AssetImage('assets/welcome.png'))),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Spacer(flex: 1),
              Text(
                'مرحبا بك',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 50,
                    color: AppColors.white),
              ),
              SizedBox(height: 8),
              Text(
                "لقد قمت بستحيل في selivery , فلنبداء برفع بينات سيارتك",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 25,
                    color: AppColors.white),
              ),
              Spacer(flex: 3),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: screenSize(context).width * .6,
                  child: carInfoButtonWidget(context, () {
                    navigateOff(UploadCategoryView());
                  }),
                ),
              ),
              Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }
}
