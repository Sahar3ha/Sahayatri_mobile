import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sahayatri/features/vehicles/domain/entity/vehicle_entity.dart';
import 'package:sahayatri/features/vehicles/domain/usecase/get_all_vehicles.dart';
import 'package:sahayatri/features/vehicles/presentation/view_model/vehicle_view_model.dart';

import '../../test_data/vehicle_entity_test.dart';
import 'vehicle_unit_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<GetAllVehicleUseCase>(),
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late ProviderContainer container;
  late GetAllVehicleUseCase mockGetAllVehiclesUsecase;
  late List<VehicleEntity> vehicleEntity;
  int page = 0;

  setUpAll(() async {
    mockGetAllVehiclesUsecase = MockGetAllVehicleUseCase();
    vehicleEntity = await getvehicles();
    when(mockGetAllVehiclesUsecase.getAllVehicles(page))
        .thenAnswer((_) async => const Right([]));
    container = ProviderContainer(overrides: [
      vehicleViewModelProvider
          .overrideWith((ref) => VehicleViewModel(mockGetAllVehiclesUsecase))
    ]);
  });
  test('check for the list of batches when calling vehicles', () async {
    when(mockGetAllVehiclesUsecase.getAllVehicles(page))
        .thenAnswer((_) => Future.value(Right(vehicleEntity)));

    await container.read(vehicleViewModelProvider.notifier).getAllVehicles();

    final vehicleState = container.read(vehicleViewModelProvider);

    expect(vehicleState.isLoading, false);
    expect(vehicleState.vehicles.length, 4);
  });
}
