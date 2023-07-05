import 'package:app6/screens/weather_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WeatherModel {
  final String cityName;
  final double temperature;
  final String weatherDescription;

  WeatherModel({
    required this.cityName,
    required this.temperature,
    required this.weatherDescription,
  });
}
