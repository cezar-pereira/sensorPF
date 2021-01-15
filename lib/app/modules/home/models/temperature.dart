import 'package:flutter/material.dart';

class Temperatures {
  Temperatures({
    @required this.average,
    @required this.maximum,
    @required this.minimum,
    @required this.real,
  });

  double average;
  double maximum;
  double minimum;
  double real;

  factory Temperatures.fromJson(Map<dynamic, dynamic> json) => Temperatures(
        average: json["average"].toDouble(),
        maximum: json["maximum"].toDouble(),
        minimum: json["minimum"].toDouble(),
        real: json["real"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "average": average,
        "maximum": maximum,
        "minimum": minimum,
        "real": real,
      };
}
