import 'dart:developer';
import 'dart:convert';
import 'dart:io';

import 'package:app6/models/weather_model.dart';
import 'package:http/http.dart' as http;

import '../constants/weather_constants.dart';

class WeatherService {
  Future<WeatherModel?> fetchWeatherData(String city) async {
    if (await isInternetConnected()) {
      return fetchWeatherDataFromAPI(city);
    } else {
      print(
          'No internet connection. Fetching weather data from local storage.');
    }
  }

  Future<bool> isInternetConnected() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  Future<WeatherModel?> fetchWeatherDataFromAPI(String city) async {
    const apiKey = Constants.apiKey;
    final url =
        'https://api.weatherapi.com/v1/current.json?key=f97ea34857344888aec132935231107&q=$city';
    // 'https://api.weatherapi.com/v1/current.json?key=$apiKey&q=$city';
    final response = await http.get(Uri.parse(url));
    log(response.body.toString());
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      final WeatherModel model = WeatherModel.fromJson(jsonResponse);
      return model;
    } else {
      log('Failed to fetch data from API');
      return null;
    }
  }
}
