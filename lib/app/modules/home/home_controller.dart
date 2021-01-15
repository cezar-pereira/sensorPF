import 'package:flutter/material.dart';
import 'package:sensor_pf/app/modules/core/repositories/sensor_repository.dart';

import 'models/sensor.dart';

class HomeController {
  SensorRepository _sensorRepository = SensorRepository();
  List<Sensor> _sensors = [];
  ValueNotifier<Sensor> _sensorSelected = ValueNotifier(Sensor());
  int indexPage = 0;

  Stream<dynamic> getStream() => this._sensorRepository.getStream();

  void buildListSensor({@required AsyncSnapshot snapshot}) {
    this._sensors.clear();

    snapshot.data.snapshot.value['sensors'].forEach((key, json) {
      this._sensors.add(Sensor.fromJson(json: json, key: key));
    });

    this._sensors.sort((Sensor sensorA, Sensor sensorB) =>
        sensorA.createdAt.compareTo(sensorB.createdAt));

    this._sensorSelected.value = this._sensors[0];
  }

  double calculatePercentToAlert() {
    return this._sensorSelected.value.temperatures.real /
        this._sensorSelected.value.settings.temperatureAlert;
  }

  Future<bool> addSensor(Sensor sensor) async {
    this._sensorRepository.save(sensor: sensor);
    return true;
  }

  List<Sensor> get listSensors => this._sensors;

  set sensorSelected(Sensor sensor) {
    this._sensorSelected.value = sensor;
  }

  get sensorSelected => this._sensorSelected;
}
