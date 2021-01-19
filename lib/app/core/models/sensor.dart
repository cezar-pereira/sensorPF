import 'dart:convert';

import 'package:flutter/material.dart';

import 'settings.dart';
import 'temperature.dart';

Sensor sensorFromJson(String str, String key) =>
    Sensor.fromJson(json: json.decode(str), key: key);

String sensorToJson(Sensor data) => json.encode(data.toJson());

class Sensor {
  String id;
  String name;
  String createdAt;
  bool checkTemperature = false;
  Settings settings;
  Temperatures temperatures;

  Sensor({
    this.id,
    this.name,
    this.createdAt,
    this.checkTemperature,
    this.settings,
    this.temperatures,
  });

  Sensor copyWith({
    String name,
    Settings settings,
  }) =>
      Sensor(
          id: this.id,
          name: name ?? this.name,
          createdAt: this.createdAt,
          checkTemperature: this.checkTemperature,
          settings: settings ?? this.settings,
          temperatures: this.temperatures);

  factory Sensor.fromJson(
          {@required Map<dynamic, dynamic> json, @required String key}) =>
      Sensor(
        id: key,
        name: json["name"],
        createdAt: json["createdAt"],
        checkTemperature: json["CheckTemperature"],
        settings: Settings.fromJson(json["Settings"]),
        temperatures: Temperatures.fromJson(json["Temperatures"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "createdAt": createdAt,
        "CheckTemperature": checkTemperature,
        "Settings": settings.toJson(),
        "Temperatures": temperatures.toJson()
      };
}
