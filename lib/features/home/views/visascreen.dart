import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:selivery_driver/controllers/visacontroller.dart';
import 'package:selivery_driver/core/class/statusrequst.dart';
import 'package:selivery_driver/core/functions/global_function.dart';
import 'package:selivery_driver/features/home/views/main_view.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VisaScreen extends StatelessWidget {
  const VisaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(VisaController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text("فيزا",
          style:TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.greenAccent
          ),),
        centerTitle: true,
        leading: IconButton(onPressed: (){
          navigatorOff(context, MainView());
        },icon: Icon(Icons.arrow_back,color: Colors.black,),),
      ),
      body:GetBuilder<VisaController>(builder: (controller){
        if(controller.statusRequest==StatusRequest.loading){
          return Center(child: CircularProgressIndicator());
        }else{
          return WebView(
            initialUrl: '${controller.url}',
            javascriptMode: JavascriptMode.unrestricted,
          );
        }
      },),
    );
  }
}
