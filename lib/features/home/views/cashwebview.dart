import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../core/functions/global_function.dart';
import 'main_view.dart';

class  CashWebViewScreen extends StatelessWidget {
  final String url;
  const  CashWebViewScreen({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text("كاش",
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
      body:WebView(
      initialUrl: '$url',
      javascriptMode: JavascriptMode.unrestricted,
    ),
    );
  }
}
