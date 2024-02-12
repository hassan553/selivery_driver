import 'package:get/get.dart';
import '../core/class/statusrequst.dart';
import '../dataforcrud/visa.dart';

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
      
       url =response['url'];
      

    }else{
     
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