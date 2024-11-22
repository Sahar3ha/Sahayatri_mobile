import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sahayatri/core/failure/failure.dart';
import 'package:sahayatri/features/vehicles/data/data_source/vehicle_data_source.dart';
import 'package:sahayatri/features/vehicles/domain/entity/vehicle_entity.dart';
import 'package:sahayatri/features/vehicles/domain/repository/vehicle_repository.dart';

final vehicleRemoteRepositoryProvider =
    Provider.autoDispose<IVehicleRepository>(
  (ref) => VehicleRemoteRepoImpl(
    vehicleRemoteDataSource: ref.read(vehicleDataSourceProvider),
  ),
);

class VehicleRemoteRepoImpl implements IVehicleRepository {
  final VehicleDataSource vehicleRemoteDataSource;

  const VehicleRemoteRepoImpl({required this.vehicleRemoteDataSource});

 
  @override
  Future<Either<Failure, List<VehicleEntity>>> getAllVehicles(int page) {
    return vehicleRemoteDataSource.getAllVehicles(page);
  }
}
