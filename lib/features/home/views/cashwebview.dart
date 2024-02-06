import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../core/functions/global_function.dart';
import 'main_view.dart';

class CashWebViewScreen extends StatefulWidget {
  final String url;
  const CashWebViewScreen({super.key, required this.url});

  @override
  State<CashWebViewScreen> createState() => _CashWebViewScreenState();
}

class _CashWebViewScreenState extends State<CashWebViewScreen> {
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
        ..loadRequest(Uri.parse(widget.url));
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
        title: Text(
          "كاش",
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.greenAccent),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            navigatorOff(context, MainView());
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: WebViewWidget(controller: controller!),
    );
  }
}
