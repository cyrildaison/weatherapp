import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/weather_controllers.dart';

class WeatherScreen extends StatelessWidget {
  final WeatherController weatherController = Get.put(WeatherController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(
              () => Text(
                'City: ${weatherController.weather.value.cityName}',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Obx(
              () => Text(
                'Temperature: ${weatherController.weather.value.temperature.toStringAsFixed(1)}°C',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Obx(
              () => Text(
                'Weather: ${weatherController.weather.value.weatherDescription}',
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                weatherController.fetchWeatherData('London');
              },
              child: Text('Fetch Weather'),
            ),
          ],
        ),
      ),
    );
  }
}
