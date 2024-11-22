import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sahayatri/core/failure/failure.dart';
import 'package:sahayatri/features/vehicles/domain/entity/vehicle_entity.dart';
import 'package:sahayatri/features/vehicles/domain/repository/vehicle_repository.dart';

final getAllVehicleUseCaseProvider = Provider.autoDispose<GetAllVehicleUseCase>(
  (ref) =>
      GetAllVehicleUseCase(repository: ref.read(vehicleRepositoryProvider)),
);

class GetAllVehicleUseCase {
  final IVehicleRepository repository;

  GetAllVehicleUseCase({required this.repository});

  Future<Either<Failure, List<VehicleEntity>>> getAllVehicles(int page) async {
    return await repository.getAllVehicles(page);
  }
}
