import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quick_update/screen/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(const Duration(seconds: 4), (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    });
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    return Scaffold(
      body: Column(
        children: [
          SizedBox( height: height * .17,),
          Image.asset('images/splashimage.png',
          fit: BoxFit.cover,
          height: height * .55,
          ),
          SizedBox(height:height * 0.04),
          const SpinKitChasingDots(
            color: Color.fromRGBO(255, 234, 157, 100),
            size: 40,
          )
        ],
      ),
    );
  }
}