import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/weather_controllers.dart';

class WeatherHistoryScreen extends StatelessWidget {
  final WeatherController weatherController = Get.put(WeatherController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather History'),
      ),
      body: Obx(
        () => weatherController.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : weatherController.hasError.value
                ? Center(
                    child: Text(
                        'Error occurred: ${weatherController.error.value}'),
                  )
                : weatherController.weatherList.isNotEmpty
                    ? ListView.builder(
                        itemCount: weatherController.weatherList.length,
                        itemBuilder: (context, index) {
                          final weather = weatherController.weatherList[index];
                          return ListTile(
                            title: Text(weather.location!.name),
                            subtitle: Text('${weather.current!.tempC} C'),
                          );
                        },
                      )
                    : const Center(
                        child: Text('No weather data found.'),
                      ),
      ),
    );
  }
}
