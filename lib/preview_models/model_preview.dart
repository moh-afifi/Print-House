import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'dart:async';

class Model extends StatelessWidget {
  Model({this.appBarTitle,this.modelUrl});
  final String appBarTitle , modelUrl;
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GradientAppBar(
          centerTitle: true,
          title: Text(
            appBarTitle,
            style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 40),
          ),
          elevation: 0.0,
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[Color(0xFFBF1215), Color(0xFF3A6186)]),
        ),
        body:WebView(
          initialUrl: modelUrl,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
        )
    );
  }
}






