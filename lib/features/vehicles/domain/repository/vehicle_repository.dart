import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sahayatri/core/failure/failure.dart';
import 'package:sahayatri/features/vehicles/data/repository/vehicle_remote_repo.dart';
import 'package:sahayatri/features/vehicles/domain/entity/vehicle_entity.dart';

final vehicleRepositoryProvider = Provider.autoDispose<IVehicleRepository>(
  (ref) {
    return ref.read(vehicleRemoteRepositoryProvider);
  },
);

abstract class IVehicleRepository {
  Future<Either<Failure, List<VehicleEntity>>> getAllVehicles(int page);
  
}