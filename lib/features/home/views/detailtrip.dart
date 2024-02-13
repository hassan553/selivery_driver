import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../controllers/tripdetails.dart';
import '../../../core/class/statusrequst.dart';
import '../../../core/functions/global_function.dart';
import 'chats.dart';
import 'package:geocoding/geocoding.dart';

import '../../../core/rescourcs/app_colors.dart';
import 'package:get/get.dart';
class TripDetails extends StatefulWidget {
  final String image;
  final String name;
  final String id;
  final String status;
  final String clientid;
  final String devicetoken;
  final double pick1;
  final double pick2;
  final double des1;
  final double des2;
  const TripDetails({super.key, required this.image,
    required this.name, required this.id,
    required this.status, required this.clientid,
    required this.pick1, required this.pick2,
    required this.des1, required this.des2,
    required this.devicetoken});

  @override
  State<TripDetails> createState() => _TripDetailsState();
}

class _TripDetailsState extends State<TripDetails> {
  Position? position;
  Completer<GoogleMapController>? completercontroller;
  CameraPosition? kGooglePlex;
  late GoogleMapController mapController;
  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPiKey = "AIzaSyAS3BGUrmQusXe0pctVL6VALzlJHlIBD1o";

  showlocationname()async{

    List<Placemark> placemarks = await
    placemarkFromCoordinates(27.0947005,31.2970836);
    print("location name ${placemarks[0]}");

  }
  @override
  void initState() {
    super.initState();
    showlocationname();
    /// origin marker
    _addMarker(LatLng(widget.pick1, widget.pick2), "origin",
        BitmapDescriptor.defaultMarker);

    /// destination marker
    _addMarker(LatLng(widget.des1, widget.des2), "destination",
        BitmapDescriptor.defaultMarkerWithHue(80));
    _getPolyline();
  }
  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
  }

  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker =
    Marker(markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;
  }
  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id, color: Colors.red,
        width:5,points: polylineCoordinates);
    polylines[id] = polyline;
    setState(() {});
  }

  _getPolyline() async {
    PolylineResult result = await polylinePoints.
    getRouteBetweenCoordinates(
      googleAPiKey,
      PointLatLng(widget.pick1, widget.pick2),
      PointLatLng(widget.des1, widget.des2),
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    //  polylinePoints.decodePolyline("_p~iF~ps|U_ulLnnqC_mqNvxq`@");
    // polylineCoordinates.add(LatLng(widget.pick1, widget.pick2));
    // polylineCoordinates.add(LatLng(widget.des1, widget.des2));

    _addPolyLine();
  }
  @override
  Widget build(BuildContext context) {
    print(widget.pick2);
    Get.put(DetailsTripController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("تفاصيل الرحلة",style: TextStyle(
            color: Colors.white,
            fontSize: 30
        ),),
        backgroundColor:AppColors.primaryColor ,
        centerTitle: true,
      ),
      body: GetBuilder<DetailsTripController>(builder: (controller){
        if(controller.statusRequest==StatusRequest.loading){
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.green,
            ),
          );
        }else if(widget.status=="requested"){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //google map for drow line
                if(controller.kGooglePlex!=null)
                Expanded(child:
                    GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: LatLng(widget.pick1, widget.pick2),
                        zoom: 15,
                      ),
                      myLocationEnabled: true,
                      tiltGesturesEnabled: true,
                      compassEnabled: true,
                      scrollGesturesEnabled: true,
                      zoomGesturesEnabled: true,
                      mapType: MapType.normal,
                      onMapCreated: _onMapCreated,
                      markers: Set<Marker>.of(markers.values),
                      polylines: Set<Polyline>.of(polylines.values),
                    ),
                    ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MaterialButton(
                      color: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),

                      ),
                      onPressed: (){
                         controller.acceptTrip(widget.id);
                      },child: const Text("موافقة",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),),),
                    MaterialButton(
                      color: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),

                      ),
                      onPressed: (){
                        controller.rejectTrip(widget.id);
                      },child: const Text("رفض",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),),),
                  ],
                )
              ],
            ),
          );
        }else if(widget.status=="accepted"){
          //driver make ststus arrived
           return Center(
             child:Column(
               crossAxisAlignment: CrossAxisAlignment.center,
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 MaterialButton(
                   color: Colors.green,
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(20),

                   ),
                   onPressed: (){
                      controller.arrivedtoclient(widget.id);
                   },child: const Text("تم الوصول الي العميل",
                   style: TextStyle(
                     color: Colors.black,
                     fontSize: 20,
                   ),),),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     const Text("تواصل مع العميل ",
                       style: TextStyle(
                         color: Colors.green,
                         fontSize: 20,
                       ),),
                     IconButton(onPressed: (){
                       navigateTo(ChatScreen(
                         devicetoken: widget.devicetoken,
                         clientid: widget.clientid,));
                     },
                         icon: const Icon(Icons.chat_bubble,size: 25,
                           color: Colors.green,))
                   ],
                 ),
               ],
             ),
           );
        }
        else if(widget.status=="started"){
          //driver ended trip
          return Center(
            child:MaterialButton(
              color: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),

              ),
              onPressed: (){
                 controller.endedTrip(widget.id);
              },child: const Text("تم توصيل العميل بنجاح",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),),),
          );
        }
        else if(widget.status=="ended"){
          return const Center(child: Text("تم الانتهاء من الرحلة",
          style: TextStyle(
            color: Colors.black,
            fontSize: 25
          ),));
        }else{
          return Container();
        }
      },),
    );
  }
}
