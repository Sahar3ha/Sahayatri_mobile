import 'package:sahayatri/features/vehicles/domain/entity/vehicle_entity.dart';

class VehicleState {
  final bool isLoading;
  final List<VehicleEntity> vehicles;
  final int page;
  final bool hasReachedMax;

  VehicleState(
      {required this.isLoading,
      required this.vehicles,
      required this.page,
      required this.hasReachedMax
      });

  factory VehicleState.initial(){ 
    return VehicleState(
      isLoading: false, 
      vehicles: [], 
      hasReachedMax: false,
      page: 0
      );
      }

  VehicleState copyWith({
    bool? isLoading,
    List<VehicleEntity>? vehicles,
    bool? hasReachedMax,
    int? page
  }) {
    return VehicleState(
      isLoading: isLoading ?? this.isLoading,
      vehicles: vehicles ?? this.vehicles,
      page: page?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}
