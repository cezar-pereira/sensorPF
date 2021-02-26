import 'package:flutter/material.dart';
import 'package:sensor_pf/app/core/functions/checkConnectionNetwork.dart';
import 'package:sensor_pf/app/core/models/sensor.dart';
import 'package:sensor_pf/app/core/models/settings.dart';
import 'package:sensor_pf/app/core/models/temperature.dart';
import 'package:sensor_pf/app/core/repositories/sensor_repository.dart';

class AddSensorController {
  SensorRepository _sensorRepository = SensorRepository();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController temperatureAlertController = TextEditingController();
  TextEditingController intervalToUpdateController = TextEditingController();

  Future<bool> addSensor() async {
    if (await CheckConnectionNetwork().checkConnection()) {
      Settings settings = Settings(
          email: emailController.text,
          intervalToUpdate: int.parse(intervalToUpdateController.text),
          temperatureAlert: double.parse(temperatureAlertController.text));

      Sensor sensor = Sensor(
        checkTemperature: false,
        name: nameController.text,
        createdAt: DateTime.now().toString(),
        settings: settings,
        temperatures: Temperatures(),
      );

      return await this._sensorRepository.addSensor(sensor: sensor);
    } else
      return false;
  }
}
