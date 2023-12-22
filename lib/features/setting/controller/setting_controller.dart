import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/functions/checkinternet.dart';
import '../../../core/functions/global_function.dart';
import '../../../core/helper/notifictions_helper.dart';
import '../../../core/services/cache_storage_services.dart';
import '../../../core/widgets/snack_bar_widget.dart';
import '../../auth/presentation/views/login_view.dart';

class SettingController extends GetxController {
  void openWhatsApp() async {
    try {
      final url = Uri.parse('https://wa.me/+201003208297');
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw 'لقد حدث خطا';
      }
    } catch (error) {}
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
    CacheStorageServices().clear();
    navigateOff(const DriverLoginView());
  }
}
