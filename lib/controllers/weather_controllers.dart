import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../weather_model.dart';

class WeatherController extends GetxController {
  var weather = WeatherModel(
    cityName: '',
    temperature: 0.0,
    weatherDescription: '',
  ).obs;

  final apiKey = 'YOUR_API_KEY'; // Replace with your actual API key

  Future<void> fetchWeatherData(String city) async {
    final url =
        'http://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey';

    final response = await http.get(Uri.parse(url));
    final data = json.decode(response.body);

    weather.value = WeatherModel(
      cityName: data['name'],
      temperature: data['main']['temp'],
      weatherDescription: data['weather'][0]['description'],
    );
  }
}
