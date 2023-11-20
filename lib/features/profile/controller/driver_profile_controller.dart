
import 'package:get/get.dart';
import 'package:http/http.dart';
import '../data/driverdata.dart';

import '../../../../core/class/statusrequst.dart';
import '../../../../core/functions/handlingdata.dart';
import '../drivermodel.dart';

class DriverProfileController extends GetxController{

  StatusRequest  statusRequest = StatusRequest.none;
  DriverData driverData = DriverData(Get.find());

  late DriverProfileModel driverProfileModel=DriverProfileModel();


  getDriverData() async{
    statusRequest = StatusRequest.loading;
    update();
    var response = await driverData.getData();
    statusRequest = handlingData(response);
    //print("resonse ${response}");
    // statusRequest = StatusRequest.success;
    // print(driverProfileModel);
    if(StatusRequest.success == statusRequest){
      print("ok");
      // if(response.statusCode == 200){
      //   print("okkk");
      //  // driverProfileModel= DriverProfileModel.fromJson(response['driver']);
      //  // print(driverProfileModel);
      // }else{
      //   // Get.defaultDialog(title: "33".tr,
      //   //     middleText: "37".tr);
      //   print("error get driver");
      //   statusRequest = StatusRequest.failure;
      // }
      driverProfileModel= DriverProfileModel.fromJson(response);
    }else{
      print("get profile error");
      statusRequest = StatusRequest.failure;

    }
    update();
  }

  // updateData(String name,String phone,age)async{
  //   statusRequest = StatusRequest.loading;
  //   update();
  //   var response = await driverData.updateData(name,
  //       phone, age);
  //   statusRequest = handlingData(response);
  //   print("update response ${response}");
  //   update();
  // }

  @override
  void onInit() {
    getDriverData();
    print("oninit");
    super.onInit();
  }
}