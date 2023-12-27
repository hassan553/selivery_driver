import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:selivery_driver/core/class/statusrequst.dart';
import 'package:selivery_driver/core/functions/global_function.dart';
import 'package:selivery_driver/dataforcrud/cash.dart';

import '../core/functions/handlingdata.dart';
import '../features/home/views/cashwebview.dart';

class CashController extends GetxController{
  StatusRequest statusRequest = StatusRequest.none;

  CashDate cashDate =CashDate(Get.find());

  TextEditingController ? phoneController;
  String ? url;

  sendPhone()async{
    if(phoneController!.text.isEmpty) return Get.defaultDialog(title: "تنبية",middleText: "من فضلك ادخل رقم الكاش");
    statusRequest = StatusRequest.loading;
    update();
    var response = await cashDate.PostData(phoneController!.text);
    statusRequest = handlingData(response);
    if(StatusRequest.success == statusRequest){
      //print(response['url']);
       url =response['url'];
       if(url!.isEmpty) return Get.defaultDialog(title: "تنبية",middleText: "من فضلك ادخل رقم هاتف علية محفظة ");
       //go to webview for cash
      navigateTo(CashWebViewScreen(url:url.toString(),));

    }else{
      print("someerror");
    }
    update();
  }


  @override
  void onInit() {
    phoneController = TextEditingController();

    super.onInit();
  }
}