import 'package:flutter/material.dart';
import 'package:sensor_pf/app/core/models/sensor.dart';

abstract class ISensorRepository {
  Stream<dynamic> getStream();

  Future<bool> remove({@required Sensor sensor});

  Future<bool> addSensor({@required Sensor sensor});

  Future<bool> update({@required Sensor sensor});

  Future<bool> requestTemperatureUpdate({@required Sensor sensor});
}
