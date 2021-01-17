import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sensor_pf/app/modules/core/models/sensor.dart';
import 'package:sensor_pf/app/modules/core/repositories/sensor_repository_interface.dart';

class SensorRepository extends ISensorRepository {
  final DatabaseReference reference = FirebaseDatabase.instance.reference();

  @override
  Stream<dynamic> getStream() {
    return reference.onValue;
  }

  @override
  Future<bool> addSensor({@required Sensor sensor}) async {
    return reference
        .child("sensors")
        .push()
        .set(sensor.toJson())
        .then((_) => true)
        .timeout(Duration(seconds: 5), onTimeout: () => false);
  }

  @override
  Future<bool> update({@required Sensor sensor}) async {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<bool> delete({@required Sensor sensor}) async {
    // TODO: implement delete
    throw UnimplementedError();
  }
}
