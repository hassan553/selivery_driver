import 'package:flutter/material.dart';
import '../../../core/functions/global_function.dart';
import '../../../core/services/cache_storage_services.dart';
import '../../../core/widgets/custom_image.dart';
import '../../../core/widgets/custom_sized_box.dart';
import '../../../core/widgets/responsive_text.dart';
import '../../../core/rescourcs/app_colors.dart';
import '../../../core/widgets/custom_appBar.dart';
import 'package:get/get.dart';

import '../controller/setting_controller.dart';

class SettingView extends StatefulWidget {
  const SettingView({super.key});

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  final controller = Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: customAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            languageWidget(),
            const CustomSizedBox(value: .03),
            notificationWidget(),
            const CustomSizedBox(value: .03),
            settingWidget('assets/Man On Phone.png', ' تواصل معنا'),
            const CustomSizedBox(value: .03),
            logoutWidget(context),
          ],
        ),
      ),
    );
  }

  Widget logoutWidget(BuildContext context) {
    return InkWell(
      onTap: () => controller.logout(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.logout,
            color: Colors.red,
            size: screenSize(context).width * .07,
          ),
          const SizedBox(width: 5),
          const ResponsiveText(
            text: 'تسجيل الخروج',
            scaleFactor: .06,
            color: Colors.red,
          ),
        ],
      ),
    );
  }

  Widget settingWidget(String imagePath, String title) {
    return InkWell(
      onTap: () => controller.openWhatsApp(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomAssetsImage(path: imagePath),
          ResponsiveText(
            text: title,
            scaleFactor: .06,
          ),
        ],
      ),
    );
  }

  Widget notificationWidget() {
    return GetBuilder<SettingController>(
      builder: (controller) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomAssetsImage(path: 'assets/Doorbell.png'),
              const ResponsiveText(
                text: 'الإشعارات',
                scaleFactor: .06,
              ),
            ],
          ),
          const Spacer(
            flex: 3,
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.primaryColor.withOpacity(.02)),
            child: Row(
              children: [
                InkWell(
                  onTap: () => controller.subscribe(context),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                      color: CacheStorageServices().isEnalbed
                          ? Colors.green
                          : const Color(0xff262E2D),
                    ),
                    child: const ResponsiveText(
                      text: 'تفعيل',
                      scaleFactor: .04,
                      color: AppColors.white,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => controller.unSubscribe(context),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        topLeft: Radius.circular(8),
                      ),
                      color: CacheStorageServices().isEnalbed
                          ? AppColors.primaryColor.withOpacity(.3)
                          : Colors.green,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomAssetsImage(path: 'assets/No Audio.png'),
                        const SizedBox(width: 3),
                        const ResponsiveText(
                          text: 'كتم',
                          scaleFactor: .04,
                          color: AppColors.black,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(
            flex: 1,
          ),
        ],
      ),
    );
  }

  Row languageWidget() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomAssetsImage(path: 'assets/Geography.png'),
            const ResponsiveText(
              text: 'اللغه',
              scaleFactor: .06,
            ),
          ],
        ),
        const Spacer(
          flex: 3,
        ),
        const ResponsiveText(
          text: 'العربية',
          scaleFactor: .06,
        ),
        const Spacer(
          flex: 1,
        ),
      ],
    );
  }
}
