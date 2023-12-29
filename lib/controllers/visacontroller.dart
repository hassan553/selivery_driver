import 'package:get/get.dart';
import 'package:selivery_driver/core/class/statusrequst.dart';
import 'package:selivery_driver/dataforcrud/visa.dart';

import '../core/functions/handlingdata.dart';

class VisaController extends GetxController{

  StatusRequest statusRequest =StatusRequest.none;

  VisaData visaData =VisaData(Get.find());

  String ? url ;

  getVisaUrl()async{
    statusRequest = StatusRequest.loading;
    update();
    var response = await visaData.getData();
    statusRequest = handlingData(response);
    if(StatusRequest.success == statusRequest){
       //print(response['url']);
       url =response['url'];
       print("$url");

    }else{
      print("someerror");
    }
    update();
  }

  @override
  void onInit() {
    getVisaUrl();
    // TODO: implement onInit
    super.onInit();
  }

}