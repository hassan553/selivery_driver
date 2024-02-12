import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/functions/global_function.dart';
import 'payment.dart';
import '../../../core/contants/api.dart';
import '../../../core/services/cache_storage_services.dart';
import 'rental_sale_car_view/order_car_view.dart';
import '../../../core/rescourcs/app_colors.dart';
import '../../../core/widgets/custom_appBar.dart';
import '../widgets/category_items.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';


class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

   getProfileDate() async {
    try {
      final response = await http.get(
        driverProfile,
        headers: authHeadersWithToken(CacheStorageServices().token),
      );
      final result = jsonDecode(response.body);
      if (response.statusCode == 200) {
        await CacheStorageServices().
        setDate(result['driver']['subscription_expiry']);
        handeldate();
        return "";
      } else {
        return "";
      }
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  //format date
handeldate(){
  String formattedDate = DateFormat('yyyy-MM-dd').
  format(DateTime.now());
  if(formattedDate == CacheStorageServices().date.split("T").first){
    Get.defaultDialog(
        title: "مرحبأ",
        middleText: "الرجاء الاشتراك في خدمتنا لكي يسمح لك باستخدام التطبيق والقيام بالرحالات ",
    onConfirm: (){
          navigateTo(const PaymentScreen());
    },
    textConfirm: "أشتراك",
        barrierDismissible: true);
  }else{
    print("noo");
  }
}

  @override
  void initState() {
     getProfileDate();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: customAppBar(context),
      body: ListView(
        children: const [
          SizedBox(height: 10),
          // CategoryItem(
          //   imagePath: 'assets/orderCar.png',
          //   title: 'طلب مركبة',
          //   isRental: false,
          //   screen: GetLocationFromUserView(),
          // ),
          CategoryItem(
            imagePath: 'assets/rentalCar.png',
            title: 'تأجير مركبة',
            isRental: true,
            screen: OrderCarView(
              isRental: true,
            ),
          ),
          CategoryItem(
            imagePath: 'assets/buyCar.png',
            title: 'شراء مركبة',
            isRental: false,
            screen: OrderCarView(
              isRental: false,
            ),
          ),
        ],
      ),
    );
  }
}
