import 'dart:convert';

import 'package:covid19_kavach/utilities/Colors.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  WebViewController _controller;
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getPageBackgroundColor(),
      body: Stack(
        children: <Widget>[
          WebView(
            initialUrl: 'https://www.trackcorona.live/map',
            // initialUrl: 'https://www.bing.com/covid/local/india',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller = webViewController;
              // loadEmbeddedCode();
            },
            onPageStarted: (url) {
              setState(() {
                isLoading = true;
              });
            },
            onPageFinished: (url) {
              setState(() {
                isLoading = false;
              });
            },
          ),
          isLoading ? Center(child: CircularProgressIndicator()) : Container(),
        ],
      ),
    );
  }

  String getEmbeddedCode() {
    return '<html><body><div class="bingwidget" data-type="covid19_map" data-market="en-us" data-language="en-us"></div> <script src="http://www.bing.com/widget/bootstrap.answer.js" async=""></script></body></html>';
  }

  void loadEmbeddedCode() {
    _controller.loadUrl(Uri.dataFromString(getEmbeddedCode(),
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }
}
