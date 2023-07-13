import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../db/weatherdb.dart';
import '../models/weather_model.dart';

import '../screens/we2_screen.dart';
import '../services/weather_services.dart';

class WeatherController extends GetxController {
  Rx<WeatherModel?> weather = WeatherModel().obs;
  RxBool isLoading = false.obs;
  final weatherData = RxList<Map<String, dynamic>>([]);

  final hasError = false.obs;
  final error = ''.obs;
  final weatherList = <WeatherModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getLastSearch();
  }

  Future<void> fetchWeatherData(String city) async {
    log('entered function');
    isLoading.value = true;
    final data = await WeatherService().fetchWeatherData(city);
    if (data != null) {
      weather.value = data;
      WeatherDatabaseHelper.instance.insert(data);
      saveLastSearch(data);
      isLoading.value = false;
    } else {
      isLoading.value = false;
    }
  }

  Future<void> saveLastSearch(WeatherModel weatherData) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = json.encode(weatherData.toJson());
    await prefs.setString('lastSearch', jsonString);
    print(jsonString);
  }

  Future<void> getLastSearch() async {
    isLoading.value = true;
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('lastSearch');
    if (jsonString != null) {
      final decodedJson = json.decode(jsonString);
      final data = WeatherModel.fromJson(decodedJson);
      weather.value = data;
      isLoading.value = false;
    } else {
      isLoading.value = false;
    }
  }

  Future<void> loadWeatherData() async {
    isLoading.value = true;
    final weatherData = await WeatherDatabaseHelper.instance.getAllWeather();
    weatherList.value = weatherData;
    isLoading.value = false;
  }

  void goToWeatherDataPage() {
    Get.to(() => WeatherHistoryScreen());
    loadWeatherData();
  }
}
