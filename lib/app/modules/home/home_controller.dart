import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sensor_pf/app/modules/core/models/sensor.dart';
import 'package:sensor_pf/app/modules/core/repositories/sensor_repository.dart';

class HomeController {
  SensorRepository _sensorRepository = SensorRepository();
  List<Sensor> _sensors = [];
  ValueNotifier<Sensor> _sensorSelected = ValueNotifier(Sensor());
  int indexPage = 0;

  Stream<dynamic> getStream() => this._sensorRepository.getStream();

  void buildListSensor({@required AsyncSnapshot snapshot}) {
    this._sensors.clear();

    if (snapshot.data.snapshot.value != null) {
      snapshot.data.snapshot.value.forEach((key, json) {
        this._sensors.add(Sensor.fromJson(json: json, key: key));
      });

      this._sensors.sort((Sensor sensorA, Sensor sensorB) =>
          sensorA.createdAt.compareTo(sensorB.createdAt));

      this._sensorSelected.value = this._sensors[0];
    }
  }

  double calculatePercentToAlert() {
    return this._sensorSelected.value.temperatures.real /
        this._sensorSelected.value.settings.temperatureAlert;
  }

  Future<bool> removeSensor() async {
    if (await checkConnection())
      return this._sensorRepository.remove(sensor: this._sensorSelected.value);
    else
      return false;
  }

  List<Sensor> get listSensors => this._sensors;

  set sensorSelected(Sensor sensor) {
    this._sensorSelected.value = sensor;
  }

  get sensorSelected => this._sensorSelected;

  Future<bool> checkConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty)
        return true;
      else
        return false;
    } on SocketException catch (_) {
      return false;
    }
  }
}
