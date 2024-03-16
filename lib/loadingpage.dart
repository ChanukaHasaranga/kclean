
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kclean/webview.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  bool isVisible = false;
  double percent = 0.0;

  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (percent < 1.0) {
          percent += 0.2;

        } 
        
        else {

          timer.cancel();
                  isVisible = !isVisible;

          Future.delayed(Duration(seconds: 1), () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return webview();
            }));
          });

        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: Container(
              height: height * 0.1,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assetss/logo.png"),
                    fit: BoxFit.contain),
              ),
            ),
          ),
          
        ],
      ),
    );
  }
}