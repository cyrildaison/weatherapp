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

  Map<String, dynamic> toJson() => {
        "location": location?.toJson(),
        "current": current?.toJson(),
      };
}

class Current {
  double tempC;

  Current({
    required this.tempC,
  });

  factory Current.fromJson(Map<String, dynamic> json) => Current(
        tempC: json["temp_c"],
      );

  Map<String, dynamic> toJson() => {
        "temp_c": tempC,
      };
}

class Location {
  String name;

  Location({
    required this.name,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
