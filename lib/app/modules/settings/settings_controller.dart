import 'package:flutter/material.dart';
import 'package:sensor_pf/app/core/functions/checkConnectionNetwork.dart';
import 'package:sensor_pf/app/core/models/sensor.dart';
import 'package:sensor_pf/app/core/models/settings.dart';
import 'package:sensor_pf/app/core/repositories/sensor_repository.dart';

class SettingsController {
  SensorRepository _sensorRepository = SensorRepository();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController temperatureAlertController = TextEditingController();
  TextEditingController intervalToUpdateController = TextEditingController();

  Future<bool> updateSensor(Sensor sensor) async {
    if (await CheckConnectionNetwork().checkConnection()) {
      Settings settings = Settings(
          email: this.emailController.text,
          intervalToUpdate: int.parse(this.intervalToUpdateController.text),
          temperatureAlert: double.parse(this.temperatureAlertController.text));
      Sensor _sensor =
          sensor.copyWith(name: this.nameController.text, settings: settings);
      return await this._sensorRepository.update(sensor: _sensor);
    } else
      return false;
  }
}
