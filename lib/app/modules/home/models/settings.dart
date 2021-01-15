import 'package:flutter/material.dart';

class Settings {
  Settings({
    @required this.email,
    @required this.intervalToUpdate,
    @required this.temperatureAlert,
  });

  String email;
  int intervalToUpdate;
  int temperatureAlert;
  String password;

  Settings copyWith({
    String email,
    int intervalToUpdate,
    int temperatureAlert,
  }) =>
      Settings(
        email: email ?? this.email,
        intervalToUpdate: intervalToUpdate ?? this.intervalToUpdate,
        temperatureAlert: temperatureAlert ?? this.temperatureAlert,
      );

  factory Settings.fromJson(Map<dynamic, dynamic> json) => Settings(
        email: json["Email"],
        intervalToUpdate: json["IntervalToUpdate"],
        temperatureAlert: json["TemperatureAlert"],
      );

  Map<String, dynamic> toJson() => {
        "Email": email,
        "IntervalToUpdate": intervalToUpdate,
        "TemperatureAlert": temperatureAlert,
        "Password": password,
      };
}
