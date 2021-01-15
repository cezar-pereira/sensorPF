import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sensor_pf/app/modules/core/repositories/sensor_repository_interface.dart';
import 'package:sensor_pf/app/modules/home/models/sensor.dart';

class SensorRepository extends ISensorRepository {
  final DatabaseReference reference = FirebaseDatabase.instance.reference();

  @override
  Stream<dynamic> getStream() {
    return reference.onValue;
  }

  @override
  Future save({@required Sensor sensor}) {
    // TODO: implement save
    throw UnimplementedError();
  }

  @override
  Future update({@required Sensor sensor}) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future delete({@required Sensor sensor}) {
    // TODO: implement delete
    throw UnimplementedError();
  }
}
