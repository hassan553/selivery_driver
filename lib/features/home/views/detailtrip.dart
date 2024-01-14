import 'package:flutter/material.dart';
import 'package:selivery_driver/controllers/tripdetails.dart';
import 'package:selivery_driver/core/class/statusrequst.dart';
import 'package:selivery_driver/core/functions/global_function.dart';
import 'package:selivery_driver/features/home/views/chats.dart';

import '../../../core/rescourcs/app_colors.dart';
import 'package:get/get.dart';
class TripDetails extends StatelessWidget {
  final String image;
  final String name;
  final String id;
  final String status;
  final String clientid;
  const TripDetails({super.key, required this.image,
    required this.name, required this.id, required this.status, required this.clientid});

  @override
  Widget build(BuildContext context) {
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
        }else if(status=="requested"){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      //color: Colors.amberAccent,
                    ),
                    child: Image.network("https://www.selivery-app.com/images/$image"),
                  ),
                ),
                Center(
                  child: Text(name,style: const TextStyle(
                      fontSize: 25,
                      color: Colors.black
                  ),),
                ),
                const ListTile(
                  title: Text("السعر :35 جنيها"),
                  trailing: Icon(Icons.price_change_rounded,color: Colors.green,),
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
                         controller.acceptTrip(id);
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
                        controller.rejectTrip(id);
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
        }else if(status=="accepted"){
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
                      controller.arrivedtoclient(id);
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
                       navigateTo(ChatScreen(clientid: clientid,));
                     },
                         icon: const Icon(Icons.chat_bubble,size: 25,
                           color: Colors.green,))
                   ],
                 ),
               ],
             ),
           );
        }
        else if(status=="started"){
          //driver ended trip
          return Center(
            child:MaterialButton(
              color: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),

              ),
              onPressed: (){
                 controller.endedTrip(id);
              },child: const Text("تم توصيل العميل بنجاح",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),),),
          );
        }
        else if(status=="ended"){
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
