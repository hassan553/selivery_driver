import 'package:flutter/material.dart';
import '../../auth/presentation/views/login_view.dart';
import '../../../core/functions/global_function.dart';
import '../../../core/rescourcs/app_colors.dart';
import '../../../core/services/cache_storage_services.dart';
import '../../home/views/main_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  void splashNavTimer() {
    Future.delayed(const Duration(seconds: 2), () => navigateOff(DriverLoginView()));
  }

  checkAuth() {
    final token = CacheStorageServices().token;
    if (token.isEmpty) {
      navigateOff(DriverLoginView());
    } else {
      navigateOff(MainView());
    }
  }

  @override
  void initState() {
    splashNavTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: splashBody(),
    );
  }

 Widget splashBody() {
    return Image.asset(
      'assets/splash.jpg',
      width: screenSize(context).width,
      height: screenSize(context).height,
      fit: BoxFit.cover,
    );
  }
}
