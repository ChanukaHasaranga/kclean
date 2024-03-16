import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';



class webview extends StatefulWidget {
  const webview({super.key});

  @override
  State<webview> createState() => _webviewState();
}

class _webviewState extends State<webview> {
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;
  InAppWebViewSettings settings =
      InAppWebViewSettings(isInspectable: kDebugMode);
  PullToRefreshController? pullToRefreshController;
  PullToRefreshSettings pullToRefreshSettings = PullToRefreshSettings(
    color: Color.fromARGB(255, 4, 132, 32),
  );
  bool pullToRefreshEnabled = true;

  @override
  void initState() {
    super.initState();

    pullToRefreshController = kIsWeb
        ? null
        : PullToRefreshController(
            settings: pullToRefreshSettings,
            onRefresh: () async {
              if (defaultTargetPlatform == TargetPlatform.android) {
                webViewController?.reload();
              } else if (defaultTargetPlatform == TargetPlatform.iOS) {
                webViewController?.loadUrl(
                    urlRequest:
                        URLRequest(url: await webViewController?.getUrl()));
              }
            },
          );
  }

  @override
  Widget build(BuildContext context) {
      double Height = MediaQuery.of(context).size.height;
  double width = MediaQuery.of(context).size.width;
  
    return SafeArea(
      child: Scaffold(
          body: WillPopScope(
            onWillPop: () async{ 
      
               return false;
      
             
          
             },
      
            child: Column(children: <Widget>[
              Expanded(
                  child: InAppWebView(
                key: webViewKey,
                initialUrlRequest:
                    URLRequest(url: WebUri("https://chachingfresh.com.au/")),
                initialSettings: settings,
                pullToRefreshController: pullToRefreshController,
                onWebViewCreated: (InAppWebViewController controller) {
                  webViewController = controller;
                },
                onLoadStop: (controller, url) {
                  pullToRefreshController?.endRefreshing();
                },
                onReceivedError: (controller, request, error) {
                  pullToRefreshController?.endRefreshing();
                },
                onProgressChanged: (controller, progress) {
                  if (progress == 100) {
                    pullToRefreshController?.endRefreshing();
                  }
                },
              )),
            ]),
          )),
    );
  }
}