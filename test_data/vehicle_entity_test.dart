import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:sahayatri/features/vehicles/domain/entity/vehicle_entity.dart';

Future<List<VehicleEntity>> getvehicles() async {
  final response =
      await rootBundle.loadString('test_data/vehicle_test_data.json');
  final jsonList = await json.decode(response);
  final List<VehicleEntity> batchList = jsonList
      .map<VehicleEntity>(
        (json) => VehicleEntity.fromJson(json),
      )
      .toList();

  return Future.value(batchList);
}
