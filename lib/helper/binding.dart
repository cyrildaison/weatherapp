import 'package:app6/controllers/weather_controllers.dart';

import 'package:get/get.dart';

class ControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WeatherController(), fenix: true);
  }
}
