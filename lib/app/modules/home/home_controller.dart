import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sensor_pf/app/core/functions/checkConnectionNetwork.dart';
import 'package:sensor_pf/app/core/models/sensor.dart';
import 'package:sensor_pf/app/core/repositories/sensor_repository.dart';

class HomeController extends ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  SensorRepository _sensorRepository = SensorRepository();
  List<Sensor> _listSensors = [];
  Sensor _sensorSelected = Sensor();
  int indexPage = 0;
  double _timerRequestTemperature = 0;

  void buildListSensor({@required AsyncSnapshot snapshot}) {
    this._listSensors.clear();

    if (snapshot.data.snapshot.value != null) {
      snapshot.data.snapshot.value.forEach((key, json) {
        if (json['name'] != null)
          this._listSensors.add(Sensor.fromJson(json: json, key: key));
        else
          this._sensorRepository.remove(sensor: Sensor(id: key));
      });

      if (_listSensors.isNotEmpty) {
        this._listSensors.sort((Sensor sensorA, Sensor sensorB) =>
            sensorA.createdAt.compareTo(sensorB.createdAt));

        this._sensorSelected = this._listSensors[indexPage];
      }
    }
    notifyListeners();
  }

  double calculatePercentToAlert() {
    return this._sensorSelected.temperatures.real /
        this._sensorSelected.settings.temperatureAlert;
  }

  Future<bool> removeSensor() async {
    if (await CheckConnectionNetwork().checkConnection())
      return await this._sensorRepository.remove(sensor: this._sensorSelected);
    else
      return false;
  }

  Future<bool> requestTemperatureUpdate() async {
    if (await CheckConnectionNetwork().checkConnection())
      return await this
          ._sensorRepository
          .requestTemperatureUpdate(sensor: this._sensorSelected);
    else
      return false;
  }

  void progressBar() {
    Timer.periodic(Duration(milliseconds: 25), (Timer timer) {
      _timerRequestTemperature += 0.005;
      if (_timerRequestTemperature.toInt() == 1) {
        timer.cancel();
        _timerRequestTemperature = 0;
      }
      notifyListeners();
    });
  }

  Future<bool> singOut() => _auth.signOut().then((value) => true);

  Stream<dynamic> getStream() => this._sensorRepository.getStream();

  List<Sensor> get listSensors => this._listSensors;

  set sensorSelected(Sensor sensor) {
    this._sensorSelected = sensor;
    notifyListeners();
  }

  Sensor get sensorSelected => this._sensorSelected;
  double get timerRequestTemperature => this._timerRequestTemperature;
}
