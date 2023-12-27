import 'package:flutter/material.dart';
import 'package:selivery_driver/core/functions/global_function.dart';
import 'package:selivery_driver/core/rescourcs/app_colors.dart';
import 'package:selivery_driver/features/home/views/visascreen.dart';

import 'cashscreen.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        title: Text("الاشتراك",style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30,
          color: Colors.white
        ),),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text("أختر طريقة الدفع",style: TextStyle(
              fontSize: 29,
              fontWeight: FontWeight.bold,
              color: Colors.white
            ),),
          ),
          InkWell(
            onTap: (){
              //go to visa uri
            navigateTo(VisaScreen());
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("فيزا",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                  color: Colors.white
                ),),
                SizedBox(width: 10,),
                Container(
                  height: 120,
                  width: 120,
                  child: Image.asset("assets/visa.png"),
                )
              ],
            ),
          ),
          InkWell(
            onTap: (){
              //go to cash
              navigateTo(const CashScreen());
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("كاش",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                  color: Colors.white
                ),),
                SizedBox(width: 10,),
                Container(
                  height: 120,
                  width: 120,
                  child: Image.asset("assets/cash.jpg"),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
