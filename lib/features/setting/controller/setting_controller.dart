import 'package:get/get.dart';
import '../../auth/date/social_auth.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/functions/checkinternet.dart';
import '../../../core/functions/global_function.dart';
import '../../../core/helper/notifictions_helper.dart';
import '../../../core/services/cache_storage_services.dart';
import '../../../core/widgets/snack_bar_widget.dart';
import '../../auth/presentation/views/login_view.dart';
import '../../profile/controller/driver_profile_controller.dart';

class SettingController extends GetxController {
  final DriverProfileController _profileController =
      Get.find<DriverProfileController>();

  void openWhatsApp() async {
    try {
      final url = Uri.parse('https://wa.me/+965 6663 0325');
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw 'لقد حدث خطا';
      }
    } catch (error) {
      return Get.defaultDialog(middleText: 'لقد حدث خطا');
    }
  }

  subscribe(context) async {
    if (await checkInternet()) {
      FirebaseMessagingService.subscribeToTopic('topic');
      CacheStorageServices().setTopic(true);
    } else {
      showSnackBarWidget(
          context: context,
          message: 'لا يوجد اتصال بالانترنت',
          requestStates: RequestStates.error);
    }
    update();
  }

  unSubscribe(context) async {
    if (await checkInternet()) {
      FirebaseMessagingService.unsubscribeFromTopic('topic');
      CacheStorageServices().setTopic(false);
    } else {
      showSnackBarWidget(
          context: context,
          message: 'لا يوجد اتصال بالانترنت',
          requestStates: RequestStates.error);
    }
    update();
  }

  logout() {
    if (_profileController.driverProfileModel?.googleId != null) {
      googleLogOut();
    }
    CacheStorageServices().clear();
    navigateOff(const DriverLoginView());
  }
}
