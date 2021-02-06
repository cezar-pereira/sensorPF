import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sensor_pf/app/core/functions/checkConnectionNetwork.dart';
import 'package:sensor_pf/app/core/models/sensor.dart';
import 'package:sensor_pf/app/core/repositories/sensor_repository.dart';

class HomeController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  SensorRepository _sensorRepository = SensorRepository();
  List<Sensor> _sensors = [];
  ValueNotifier<Sensor> _sensorSelected = ValueNotifier(Sensor());
  int indexPage = 0;
  ValueNotifier<double> _timerRequestTemperature = ValueNotifier(0);

  void buildListSensor({@required AsyncSnapshot snapshot}) {
    this._sensors.clear();

    if (snapshot.data.snapshot.value != null) {
      snapshot.data.snapshot.value.forEach((key, json) {
        this._sensors.add(Sensor.fromJson(json: json, key: key));
      });

      this._sensors.sort((Sensor sensorA, Sensor sensorB) =>
          sensorA.createdAt.compareTo(sensorB.createdAt));

      this._sensorSelected.value = this._sensors[indexPage];
    }
  }

  double calculatePercentToAlert() {
    return this._sensorSelected.value.temperatures.real /
        this._sensorSelected.value.settings.temperatureAlert;
  }

  Future<bool> removeSensor() async {
    if (await CheckConnectionNetwork().checkConnection())
      return await this
          ._sensorRepository
          .remove(sensor: this._sensorSelected.value);
    else
      return false;
  }

  Future<bool> requestTemperatureUpdate() async {
    if (await CheckConnectionNetwork().checkConnection())
      return await this
          ._sensorRepository
          .requestTemperatureUpdate(sensor: this._sensorSelected.value);
    else
      return false;
  }

  void progressBar() {
    Timer.periodic(Duration(milliseconds: 25), (Timer timer) {
      _timerRequestTemperature.value += 0.005;
      if (_timerRequestTemperature.value.toInt() == 1) {
        timer.cancel();
        _timerRequestTemperature.value = 0;
      }
    });
  }

  Future<bool> singOut() => _auth.signOut().then((value) => true);

  Stream<dynamic> getStream() => this._sensorRepository.getStream();

  List<Sensor> get listSensors => this._sensors;

  set sensorSelected(Sensor sensor) {
    this._sensorSelected.value = sensor;
  }

  get sensorSelected => this._sensorSelected;
  get timerRequestTemperature => this._timerRequestTemperature;
}
