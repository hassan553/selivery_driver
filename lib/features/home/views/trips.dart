import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:selivery_driver/controllers/getrequesttrips.dart';
import 'package:selivery_driver/core/class/statusrequst.dart';
import 'package:selivery_driver/core/functions/global_function.dart';
import 'package:selivery_driver/features/home/views/detailtrip.dart';

import '../../../core/rescourcs/app_colors.dart';

class TripsScreen extends StatelessWidget {
  const TripsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(GetRequestTripsController());
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        title: Text("الطلبات",style: TextStyle(
          color: Colors.white,
          fontSize: 30
        ),),
        backgroundColor:AppColors.primaryColor ,
        centerTitle: true,
      ),
      body: GetBuilder<GetRequestTripsController>(builder: (controller){
        if(controller.statusRequest==StatusRequest.loading){
          return Center(
            child: const CircularProgressIndicator(
              color: Colors.green,
            ),
          );
        }
        else{
          return ListView.separated(
              itemBuilder: (context,index){
                return InkWell(
                  onTap: (){},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text("رحلة في انتظار الموافقة",style: TextStyle(
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
                             image: controller.Requesttrips[index].passenger!.image!,
                             name:controller.Requesttrips[index].passenger!.name! ,
                             id: controller.Requesttrips[index].sId!,
                             clientid: controller.Requesttrips[index].passenger!.sId!,
                             status: controller.Requesttrips[index].status!,
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
              itemCount: controller.Requesttrips.length);
        }
      },),
    );
  }
}
