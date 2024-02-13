import 'package:get/get.dart';

import '../core/class/statusrequst.dart';
import '../core/functions/handlingdata.dart';
import '../dataforcrud/getreuesttrips.dart';
import '../dataforcrud/models/requesttripmodel.dart';

class GetRequestTripsController extends GetxController{
  StatusRequest  statusRequest = StatusRequest.none;
  RequestTripsData reguestTripsData = RequestTripsData(Get.find());

  List<RequestTripsModel> Requesttrips = [];

  getRequestTrips()async{
    statusRequest = StatusRequest.loading;
    update();
    var response = await reguestTripsData.getData();
    statusRequest = handlingData(response);
    if(StatusRequest.success == statusRequest){
      
      List x=response['trips'];
      Requesttrips.addAll(x.
      map((e)=>RequestTripsModel.fromJson(e)));
      //print(Requesttrips);
    }else{
      
    }
    update();
  }



  @override
  void onInit() {
    getRequestTrips();
    super.onInit();
  }
}