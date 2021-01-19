import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sensor_pf/app/core/models/sensor.dart';

import 'sensor_repository_interface.dart';

class SensorRepository extends ISensorRepository {
  final DatabaseReference reference = FirebaseDatabase.instance.reference();

  @override
  Stream<dynamic> getStream() {
    return reference.onValue;
  }

  @override
  Future<bool> addSensor({@required Sensor sensor}) async {
    return reference
        .push()
        .set(sensor.toJson())
        .then((_) => true)
        .timeout(Duration(seconds: 5), onTimeout: () => false);
  }

  @override
  Future<bool> update({@required Sensor sensor}) async {
    try {
      return reference
          .child(sensor.id)
          .update(sensor.toJson())
          .then((_) => true)
          .timeout(Duration(seconds: 5), onTimeout: () => false);
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> remove({@required Sensor sensor}) async {
    try {
      return reference
          .child(sensor.id)
          .remove()
          .then((_) => true)
          .timeout(Duration(seconds: 5), onTimeout: () => false);
    } catch (e) {
      return false;
    }
  }
}
