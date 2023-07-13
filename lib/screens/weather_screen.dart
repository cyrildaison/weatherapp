import 'package:app6/screens/we2_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/weather_controllers.dart';

class WeatherScreen extends StatelessWidget {
  final TextEditingController locationController = TextEditingController();

  WeatherScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final WeatherController weatherController = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() {
              final isLoading = weatherController.isLoading.value;

              if (isLoading) {
                return const CircularProgressIndicator();
              } else if (weatherController.weather.value?.location == null ||
                  weatherController.weather.value?.current == null) {
                return const Text('No Data');
              } else {
                return Column(
                  children: [
                    Text(
                        'Location: ${weatherController.weather.value!.location!.name}'),
                    Text(
                        'Current: ${weatherController.weather.value!.current!.tempC} C'),
                  ],
                );
              }
            }),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: locationController,
                decoration: const InputDecoration(
                  labelText: 'Enter Location',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final enteredLocation = locationController.text;
                weatherController.fetchWeatherData(enteredLocation);
              },
              child: const Text('Fetch Weather'),
            ),
            ElevatedButton(
              onPressed: () => weatherController.goToWeatherDataPage(),
              child: const Text('Weather History'),
            ),
          ],
        ),
      ),
    );
  }
}
