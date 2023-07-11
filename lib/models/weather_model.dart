class WeatherModel {
  Location? location;
  Current? current;

  WeatherModel({
    this.location,
    this.current,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
        location: Location.fromJson(json["location"]),
        current: Current.fromJson(json["current"]),
      );
}

class Current {
  double tempC;

  Current({
    required this.tempC,
  });

  factory Current.fromJson(Map<String, dynamic> json) => Current(
        tempC: json["temp_c"],
      );
}

class Location {
  String name;

  Location({
    required this.name,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        name: json["name"],
      );
}
