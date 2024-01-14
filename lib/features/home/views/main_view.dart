import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:selivery_driver/features/profile/presentation/view/driver_profile_view.dart';
import '../../../controllers/categoriescontroller.dart';
import '../../../core/helper/notifictions_helper.dart';
import '../../../core/rescourcs/app_colors.dart';
import '../../../core/services/cache_storage_services.dart';
import '../../ads/views/all_ads_view.dart';
import '../../profile/controller/driver_profile_controller.dart';
import 'home_view.dart';
import '../../setting/view/setting_view.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:get/get.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  DriverProfileController controller = Get.put(DriverProfileController());
  CategoriesController categoriesController = Get.put(CategoriesController());

  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);
  IO.Socket? socket;
  Position? position;
  //Timer ? timer;
  Completer<GoogleMapController>? completercontroller;
  CameraPosition? kGooglePlex;
  Map<String, dynamic> options = {
    "transports": ['websocket'],
    "autoConnect": false,
  };
  address() {

    Timer.periodic(const Duration(seconds: 30), (Timer timer) {
      setState(() {
        socket!.emit("update_driver_location", {
          "driverId": CacheStorageServices().id,
          "location": {
            "latitude": position!.latitude,
            "longitude": position!.longitude
          },
        });
      });
    });
  }

  getCurrentLocationForDriver() async {
    position = await Geolocator.getCurrentPosition();
    kGooglePlex = CameraPosition(
      target: LatLng(position!.latitude, position!.longitude),
      zoom: 14.4746,
    );
    socket!.emit("update_driver_location", {
      "driverId": CacheStorageServices().id,
      "location": {
        "latitude": position!.latitude,
        "longitude": position!.longitude
      },
    });
  }

  initSocketForDriver() {
    socket = IO.io("https://www.selivery-app.com/", options);
    socket!.connect();
    socket!.onConnect((_) => print("connect with server"));
    socket!.emit("driverAuthenticate", CacheStorageServices().id);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getCurrentLocationForDriver();
    Future(() async {
      await FirebaseMessagingService.initialize();
    });
    //init socket
    initSocketForDriver();
    //address
    address();
    FirebaseMessagingService.getDeviceToken();
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: AppColors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style1, // Choose the nav bar style with this property.
    );
  }

  List<Widget> _buildScreens() {
    return const [
      HomeView(),
      SettingView(),
      AllAdsView(),
      DriverProfileView(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.home),
        title: ("Selivery"),
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.settings),
        title: ("الاعدادت"),
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.campaign, size: 30),
        title: ("الاشعارات"),
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.person),
        title: ("الملف الشخصي"),
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }
}
