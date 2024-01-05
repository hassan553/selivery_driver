import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:selivery_driver/controllers/cashcontroller.dart';
import 'package:selivery_driver/core/class/statusrequst.dart';

class CashScreen extends StatelessWidget {
  const CashScreen({super.key});

  @override
  Widget build(BuildContext context) {
   Get.put(CashController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("كاش",style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
          color: Colors.greenAccent
        ),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GetBuilder<CashController>
          (builder: (controller)=>Column(
          children: [
            TextFormField(
              textInputAction: TextInputAction.done,
              validator: (val){
                return null;
              

              },
              controller: controller.phoneController,
              cursorColor: Colors.white,
              style: const TextStyle(color: Colors.black),
              keyboardType: TextInputType.phone,
              onTapOutside:(e)=> FocusManager.instance.primaryFocus!.unfocus(),
              decoration: InputDecoration(
                filled: true,
                hintText: "ادخل رقم الكاش",
                fillColor: Colors.white,
                hintStyle: const TextStyle(color: Colors.black),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.black, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.black, width: 2),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.red, width: 2),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.red, width: 2),
                ),
              ),
            ),
            controller.statusRequest==StatusRequest.loading?
            const Center(child: CircularProgressIndicator()):Container(
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),),
                color: Colors.green,
                onPressed: (){
                  controller.sendPhone();
                },
                child: const Text("تم",style: TextStyle(
                    fontSize: 20,
                    color: Colors.white
                ),),),
            )
          ],
        ),),
      ),
    );
  }
}
