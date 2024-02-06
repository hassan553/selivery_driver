import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import '../core/class/statusrequst.dart';
import '../core/functions/handlingdata.dart';
import '../dataforcrud/accepttrip.dart';
import '../dataforcrud/arrivedtoclient.dart';
import '../dataforcrud/endedtrip.dart';
import '../dataforcrud/rejecttrip.dart';

class DetailsTripController extends GetxController{
//google map
  Position? position;
  Completer<GoogleMapController>? completercontroller;
  CameraPosition? kGooglePlex;
 // List<Marker> markers = [];

  StatusRequest  statusRequest = StatusRequest.none;
  AcceptTripData acceptTripData =AcceptTripData(Get.find());
  EndedTripData endedTripData = EndedTripData(Get.find());
  ArrivedToClientData arrivedToClientData =
  ArrivedToClientData(Get.find());
  RejectTripData rejectTripData = RejectTripData(Get.find());

  //google map
  // addMarkers(LatLng latLng) {
  //  // markers.clear();
  //   markers.add(
  //     Marker(
  //       markerId: const MarkerId("1"),
  //       position: latLng,
  //     ),
  //   );
  //   addPolyLine();
  // }

  getCurrentLocation() async {
    position = await Geolocator.getCurrentPosition();
    kGooglePlex = CameraPosition(
      target: LatLng(position!.latitude, position!.longitude),
      zoom: 14.4746,
    );
    //addMarkers(LatLng(position!.latitude, position!.longitude));
    statusRequest = StatusRequest.none;
    update();
  }
  //
  // //show line on google map
  // Map<MarkerId, Marker> markers = {};
  // Map<PolylineId, Polyline> polylines = {};
  // List<LatLng> polylineCoordinates = [];
  // PolylinePoints polylinePoints = PolylinePoints();
  // String googleAPiKey = "AIzaSyAS3BGUrmQusXe0pctVL6VALzlJHlIBD1o";
  // addPolyLine() {
  //   PolylineId id = PolylineId("poly");
  //   Polyline polyline = Polyline(
  //       polylineId: id, color: Colors.red,
  //       width:10,points: polylineCoordinates);
  //   polylines[id] = polyline;
  //   update();
  // }
  // getPolyline(pick1,pick2,des1,des2) async {
  //   PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
  //       googleAPiKey,
  //       PointLatLng(pick1, pick2),
  //       PointLatLng(des1, des2),
  //       travelMode: TravelMode.driving,);
  //    //polylinePoints.decodePolyline("_p~iF~ps|U_ulLnnqC_mqNvxq`@");
  //   polylineCoordinates.add(LatLng(pick1, pick2));
  //   polylineCoordinates.add(LatLng(des1, des2));
  //   // if (result.points.isNotEmpty) {
  //   //   result.points.forEach((PointLatLng point) {
  //   //     polylineCoordinates.add(LatLng(point.latitude, point.longitude));
  //   //   });
  //   // }
  //   addPolyLine();
  // }
  // Method to fetch polyline and show it on the map

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

  // _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
  //   MarkerId markerId = MarkerId(id);
  //   Marker marker =
  //   Marker(markerId: markerId, icon: descriptor, position: position);
  //   markers[markerId] = marker;
  // }
  // drawn(pick1, pick2, des1, des2){
  //   /// origin marker
  //   _addMarker(LatLng(pick1, pick2), "origin",
  //       BitmapDescriptor.defaultMarker);
  //
  //   /// destination marker
  //   _addMarker(LatLng(des1, des2), "destination",
  //       BitmapDescriptor.defaultMarkerWithHue(90));
  //   getPolyline(pick1, pick2, des1, des2);
  // }

  @override
  void onInit() {
    // TODO: implement onInit
    getCurrentLocation();
    completercontroller = Completer<GoogleMapController>();
    super.onInit();
  }
}