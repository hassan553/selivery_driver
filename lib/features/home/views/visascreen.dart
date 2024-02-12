import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/visacontroller.dart';
import '../../../core/class/statusrequst.dart';
import '../../../core/functions/global_function.dart';
import 'main_view.dart';

class VisaScreen extends StatelessWidget {
  const VisaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(VisaController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: const Text(
          "فيزا",
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.greenAccent),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            navigatorOff(context, const MainView());
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: GetBuilder<VisaController>(
        builder: (controller) {
          if (controller.statusRequest == StatusRequest.loading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            // return WebView(
            //   initialUrl: '${controller.url}',
            //   javascriptMode: JavascriptMode.unrestricted,
            // );
            //delete this return
            return Container();
          }
        },
      ),
    );
  }
}
