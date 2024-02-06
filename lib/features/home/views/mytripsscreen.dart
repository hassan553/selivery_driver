import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:selivery_driver/controllers/mytripscontroller.dart';
import 'package:selivery_driver/features/home/views/detailtrip.dart';

import '../../../core/class/statusrequst.dart';
import '../../../core/functions/global_function.dart';
import '../../../core/rescourcs/app_colors.dart';

class  MyTripsScreen extends StatelessWidget {
  const  MyTripsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MyTripsController());
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        title: const Text("رحالاتي",style: TextStyle(
            color: Colors.white,
            fontSize: 30
        ),),
        backgroundColor:AppColors.primaryColor ,
        centerTitle: true,
      ),
      body: GetBuilder<MyTripsController>(builder: (controller){
        if(controller.statusRequest==StatusRequest.loading){
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.green,
            ),
          );
        }
        else if(controller.mytrips.isEmpty){
         return const Center(
           child: Text("لا يوجد رحالات",style: TextStyle(
             fontSize: 25,
             color: Colors.black
           ),),
         );
        }else{
          return ListView.separated(
              itemBuilder: (context,index){
                return InkWell(
                  onTap: (){},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text("الرحلة التي وافقة عليها",style: TextStyle(
                          color: Colors.white,
                          fontSize: 25
                      ),),
                      MaterialButton(
                        color: Colors.amberAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),

                        ),
                        onPressed: (){
                          navigateTo(TripDetails(
                            devicetoken:controller.mytrips[index].passenger!.deviceToken! ,
                            pick1:controller.mytrips[index].pickupLocation!.coordinates!.first ,
                            pick2:controller.mytrips[index].pickupLocation!.coordinates!.last ,
                            des1:controller.mytrips[index].destinationLocation!.coordinates!.first ,
                            des2:controller.mytrips[index].destinationLocation!.coordinates!.last ,
                            image: controller.mytrips[index].passenger!.image!,
                            name:controller.mytrips[index].passenger!.
                            name! ,
                            id: controller.mytrips[index].sId!,
                            status: controller.mytrips[index].status!,
                            clientid:controller.mytrips[index].passenger!.sId! ,
                          ));
                        },child: const Text("التفاصيل",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),),),
                    ],
                  ),
                );
              },
              separatorBuilder: (context,index)=>Container(),
              itemCount: controller.mytrips.length);
        }
      },),
    );
  }
}
