import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:selivery_driver/core/widgets/custom_loading_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../controllers/visacontroller.dart';
import '../../../core/class/statusrequst.dart';
import '../../../core/functions/global_function.dart';
import 'main_view.dart';

class VisaScreen extends StatefulWidget {
  const VisaScreen({super.key});

  @override
  State<VisaScreen> createState() => _VisaScreenState();
}

class _VisaScreenState extends State<VisaScreen> {

  VisaController visaController= Get.put(VisaController());

  WebViewController? controller;
  giveControllerValue() {
    try {
      controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(const Color(0x00000000))
        ..setNavigationDelegate(
          NavigationDelegate(
            onProgress: (int progress) {
              // Update loading bar.
            },
            onPageStarted: (String url) {},
            onPageFinished: (String url) {},
            onWebResourceError: (WebResourceError error) {},
            onNavigationRequest: (NavigationRequest request) {
              if (request.url
                  .startsWith('https://www.youtube.com/watch?v=snxybJkFeUo')) {
                return NavigationDecision.prevent;
              }
              return NavigationDecision.navigate;
            },
          ),
        )
        ..loadRequest(Uri.parse(visaController.url??""));
    } catch (error) {}
  }

  @override
  void initState() {
    super.initState();
    giveControllerValue();
  }

  @override
  Widget build(BuildContext context) {

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
        builder: (controllerw) {
          if (controllerw.statusRequest == StatusRequest.loading) {
            return CustomLoadingWidget();
          } else {
            return  WebViewWidget(controller: controller!);
          }
        },
      ),
    );
  }
}
