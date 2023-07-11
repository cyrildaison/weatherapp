import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app6/models/weather_model.dart';
import 'package:app6/services/weather_services.dart';

class WeatherController extends GetxController {
  Rx<WeatherModel?> weather = WeatherModel().obs;
  RxBool isLoading = false.obs;

  Future<void> fetchWeatherData(String city) async {
    log('entered function');
    isLoading.value = true;
    final data = await WeatherService().fetchWeatherData(city);

    if (data != null) {
      weather.value = data;
      isLoading.value = false;
    } else {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        'Failed to fetch weather data',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 2),
      );
    }
  }
}
