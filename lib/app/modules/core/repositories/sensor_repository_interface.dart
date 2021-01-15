import 'package:flutter/material.dart';
import 'package:sensor_pf/app/modules/home/models/sensor.dart';

abstract class ISensorRepository {
  Stream<dynamic> getStream();

  Future delete({@required Sensor sensor});

  Future save({@required Sensor sensor});

  Future update({@required Sensor sensor});
}
