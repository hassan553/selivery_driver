import 'package:get/get.dart';

import '../core/class/statusrequst.dart';
import '../core/functions/handlingdata.dart';
import '../dataforcrud/accepttrip.dart';
import '../dataforcrud/arrivedtoclient.dart';
import '../dataforcrud/endedtrip.dart';
import '../dataforcrud/rejecttrip.dart';

class DetailsTripController extends GetxController{
  StatusRequest  statusRequest = StatusRequest.none;
  AcceptTripData acceptTripData =AcceptTripData(Get.find());
  EndedTripData endedTripData = EndedTripData(Get.find());
  ArrivedToClientData arrivedToClientData =
  ArrivedToClientData(Get.find());
  RejectTripData rejectTripData = RejectTripData(Get.find());

  acceptTrip(id)async{
    statusRequest = StatusRequest.loading;
    update();
    var response = await acceptTripData.getData(id);
    statusRequest = handlingData(response);
    if(StatusRequest.success == statusRequest){
      Get.defaultDialog(title: "هلا",
          middleText: "لقد وافقة ع الرحلة اذهب الان الي عميلك العزيز");
    }else{
      print(response);
      print("someerror to accept trips");
    }
    update();
  }

  rejectTrip(id)async{
    statusRequest = StatusRequest.loading;
    update();
    var response = await rejectTripData.getData(id);
    statusRequest = handlingData(response);
    if(StatusRequest.success == statusRequest){
      Get.defaultDialog(title: "هلا",
          middleText: "لقد قمت برفض الرحلة");
    }else{
      print(response);
      print("someerror to accept trips");
    }
    update();
  }

  endedTrip(id)async{
    statusRequest = StatusRequest.loading;
    update();
    var response = await endedTripData.getData(id);
    statusRequest = handlingData(response);
    if(StatusRequest.success == statusRequest){
      Get.defaultDialog(title: "هلا",
          middleText: "لقد تم الانتهاء من الرحلة");
    }else{
      print(response);
      print("someerror to end trips");
    }
    update();
  }

  arrivedtoclient(id)async{
    statusRequest = StatusRequest.loading;
    update();
    var response = await arrivedToClientData.getData(id);
    statusRequest = handlingData(response);
    if(StatusRequest.success == statusRequest){
      Get.defaultDialog(title: "هلا",
          middleText: "لقدتم الوصول للعميل");
    }else{
      print(response);
      print("someerror to end trips");
    }
    update();
  }
}