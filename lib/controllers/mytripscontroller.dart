import 'package:get/get.dart';

import '../core/class/statusrequst.dart';
import '../core/functions/handlingdata.dart';
import '../dataforcrud/models/requesttripmodel.dart';
import '../dataforcrud/mytrips.dart';

class MyTripsController extends GetxController{
  StatusRequest  statusRequest = StatusRequest.none;
  MyTripsData myTripsData = MyTripsData(Get.find());

  List<RequestTripsModel> mytrips = [];

  myTrips()async{
    statusRequest = StatusRequest.loading;
    update();
    var response = await myTripsData.getData();
    statusRequest = handlingData(response);
    if(StatusRequest.success == statusRequest){
      print(response['trips']);
      List x=response['trips'];
      mytrips.addAll(x.
      map((e)=>RequestTripsModel.fromJson(e)));
      //print(Requesttrips);
    }else{
      print(response);
      print("someerror to get trips");
    }
    update();
  }


  @override
  void onInit() {
    myTrips();
    super.onInit();
  }
}