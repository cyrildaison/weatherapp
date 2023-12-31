import 'package:app6/screens/weather_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      Get.off(WeatherScreen());
    });

    return Scaffold(
      body: Center(
        child: Text(
          'WEATHER APP',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
