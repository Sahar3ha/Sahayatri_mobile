import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sahayatri/config/routes/app_routes.dart';
import 'package:sahayatri/features/favourites/domain/entity/favourite_entity.dart';
import 'package:sahayatri/features/favourites/domain/usecase/get_favourite_usecase.dart';
import 'package:sahayatri/features/home/presentation/state/home_state.dart';
import 'package:sahayatri/features/notifications/domain/entity/notification.dart';
import 'package:sahayatri/features/notifications/domain/use_case/get_notification_use_case.dart';
import 'package:sahayatri/features/vehicles/domain/entity/vehicle_entity.dart';
import 'package:sahayatri/features/vehicles/domain/usecase/get_all_vehicles.dart';


final homeViewModelProvider =
    StateNotifierProvider.autoDispose<HomeViewModel, HomeState>(
  (ref) => HomeViewModel(
      getAllVehiclesUsecase: ref.read(getAllVehicleUseCaseProvider),
      getFavouriteUsecase: ref.read(getFavouriteUseCaseProvider),
      getNotificationUseCase: ref.read(getNotificationUseCaseProvider)
      ),
);

class HomeViewModel extends StateNotifier<HomeState> {
  HomeViewModel({required this.getAllVehiclesUsecase, required this.getFavouriteUsecase,required this.getNotificationUseCase}) : super(HomeState.initialState()){
    getAllData();
  }

  final GetAllVehicleUseCase getAllVehiclesUsecase;
  final GetFavouriteUseCase getFavouriteUsecase;
  final GetNotificationUseCase getNotificationUseCase;

  void changeIndex(int index) {
    state = state.copyWith(index: index);
  }

  void signOut(BuildContext context) {
    Navigator.pushReplacementNamed(context, AppRoute.loginRoute);
  }

  void getAllData() {
    state = state.copyWith(isLoading: true);
    List<VehicleEntity> vehicleList = [];
    List<FavouriteEntity> favouriteList = [];
    List<NotificationEntity> notificationList = [];

    final currentState = state;
    final page = currentState.page + 1;
    // final vehicles = currentState.vehicles;
    // final hasReachedMax = currentState.hasReachedMax;

    getAllVehiclesUsecase.getAllVehicles(page).then((value) {
      value.fold(
            (failure) => state = state.copyWith(isLoading: false),
            (batches) {
          state = state.copyWith(vehicles: vehicleList, isLoading: false);
        },
      );
    });

    getFavouriteUsecase.getFavourite(page).then((value) {
      value.fold(
            (failure) => state = state.copyWith(isLoading: false),
            (courses) {
          state = state.copyWith(favourites: favouriteList, isLoading: false);
        },
      );
    });
    getNotificationUseCase.getNotifications(page).then((value) {
      value.fold(
            (failure) => state = state.copyWith(isLoading: false),
            (courses) {
          state = state.copyWith(notifcations: notificationList, isLoading: false);
        },
      );
    });
  }
}
