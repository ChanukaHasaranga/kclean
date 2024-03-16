import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Mywebview extends StatefulWidget {
   Mywebview({

    required this.controller,
    
    
    
    super.key
    
    
    });

    final WebViewController controller;

  @override
  State<Mywebview> createState() => _MywebviewState();
}

class _MywebviewState extends State<Mywebview> {
  

var loadingercentage=0;

@override
void initState(){
  super.initState();
  widget.controller..setNavigationDelegate(
NavigationDelegate(
  onPageStarted: (url) {
    setState(() {
      loadingercentage=0;
    });

  },
  onProgress: (progress) {
    setState(() {
      loadingercentage=progress;
    });
  },
  onPageFinished: (url) {
    setState(() {
      loadingercentage=100;
    });
  },
)

  )..setJavaScriptMode(JavaScriptMode.unrestricted)..addJavaScriptChannel("SnackBar", onMessageReceived:(message){
ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message.message)));
  });
}

  Future<void> _refreshWebView() async {
    await widget.controller.reload();
  }

  @override


  Widget build(BuildContext context) {
    return Stack(
    
      children: [
        WebViewWidget(controller: widget.controller),
        if(loadingercentage<100)
        LinearProgressIndicator(
          color: Colors.green,
          value: loadingercentage/100.0,
        )
      ],
    
    );
  }
}