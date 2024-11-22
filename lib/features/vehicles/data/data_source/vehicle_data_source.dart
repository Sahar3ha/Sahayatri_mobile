import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sahayatri/config/constants/api_endpoints.dart';
import 'package:sahayatri/core/failure/failure.dart';
import 'package:sahayatri/core/networking/http_service.dart';
import 'package:sahayatri/features/vehicles/data/dto/get_all_vehicles_dto.dart';
import 'package:sahayatri/features/vehicles/data/model/vehicle_api_model.dart';
import 'package:sahayatri/features/vehicles/domain/entity/vehicle_entity.dart';

final vehicleDataSourceProvider = Provider<VehicleDataSource>((ref) {
  final dio = ref.read(httpServiceProvider);
  return VehicleDataSource(dio);
});

class VehicleDataSource {
  final Dio _dio;

  VehicleDataSource(this._dio);

  Future<Either<Failure, List<VehicleEntity>>> getAllVehicles(int page) async {
    try {
      final response = await _dio.get(
        ApiEndpoints.getAllVehicles,
        queryParameters: {
          '_page': page,
          '_limit': ApiEndpoints.limitPage,
        },
      );

      if (response.statusCode == 200) {
        GetAllVehicleDTO getAllVehicleDTO = GetAllVehicleDTO.fromJson(response.data);
        List<VehicleEntity> vehicleList = getAllVehicleDTO.data
            .map((data) => VehicleAPIModel.toEntity(data))
            .toList();
        return Right(vehicleList);
      } else {
        return Left(Failure(
          error: response.statusMessage?.toString() ?? 'Unknown error',
          statusCode: response.statusCode.toString(),
        ));
      }

    } on DioException catch (e) {
      return Left(Failure(error: e.message.toString()));
    }
  }
}
