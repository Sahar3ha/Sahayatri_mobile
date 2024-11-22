import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sahayatri/features/vehicles/domain/usecase/get_all_vehicles.dart';
import 'package:sahayatri/features/vehicles/presentation/state/vehicles_state.dart';

final vehicleViewModelProvider =
    StateNotifierProvider<VehicleViewModel, VehicleState>((ref) {
  final getAllvehicles = ref.read(getAllVehicleUseCaseProvider);
  return VehicleViewModel(getAllvehicles);
});

class VehicleViewModel extends StateNotifier<VehicleState> {
  final GetAllVehicleUseCase _getAllVehicleUseCase;
  VehicleViewModel(
    this._getAllVehicleUseCase,
  ) : super(
          VehicleState.initial(),
        ) {
    getAllVehicles();
  }

  Future resetState() async {
    state = VehicleState.initial();
    getAllVehicles();
  }

  Future getAllVehicles() async {
    state = state.copyWith(isLoading: true);
    final currentState = state;
    final page = currentState.page + 1;
    final vehicles = currentState.vehicles;
    final hasReachedMax = currentState.hasReachedMax;
    if (!hasReachedMax) {
      // get data from data source
      final result = await _getAllVehicleUseCase.getAllVehicles(page);
      result.fold(
        (failure) =>
            state = state.copyWith(hasReachedMax: true, isLoading: false),
        (data) {
          if (data.isEmpty) {
            state = state.copyWith(hasReachedMax: true);
          } else {
            state = state.copyWith(
              vehicles: [...vehicles, ...data],
              page: page,
              isLoading: false,
            );
          }
        },
      );
    }
  }
}

