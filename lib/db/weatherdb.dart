import 'dart:math';

import 'package:app6/main.dart';
import 'package:app6/models/weather_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class WeatherDatabaseHelper {
  static const _databaseName = 'weather.db';
  static const _databaseVersion = 1;
  static const _tableName = 'weather';

  WeatherDatabaseHelper._();
  static final instance = WeatherDatabaseHelper._();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = await getDatabasesPath();
    final databasePath = join(path, _databaseName);

    return await openDatabase(
      databasePath,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        location TEXT,
        temperature TEXT
      )
    ''');
  }

  Future<void> insert(WeatherModel data) async {
    Map<String, dynamic> weathermap = {
      'location': data.location!.name,
      'temperature': data.current!.tempC.toString(),
    };
    final db = await _initDatabase();
    await db.insert('weather', weathermap,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<WeatherModel>> getAllWeather() async {
    final db = await _initDatabase();
    List<Map<String, dynamic>> weatherMaps = await db.query('weather');
    List<WeatherModel> weather = [];

    for (Map<String, dynamic> weatherMap in weatherMaps) {
      WeatherModel weatherModel = WeatherModel(
        location: Location(name: weatherMap['location']),
        current: Current(tempC: double.parse(weatherMap['temperature'])),
      );
      weather.add(weatherModel);
    }
    return weather;
  }
}
