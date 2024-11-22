import 'package:flutter/widgets.dart';
import 'package:sahayatri/features/favourites/domain/entity/favourite_entity.dart';
import 'package:sahayatri/features/favourites/presentation/view/favourites_view.dart';
import 'package:sahayatri/features/favourites/presentation/view/profile_view.dart';
import 'package:sahayatri/features/notifications/domain/entity/notification.dart';
import 'package:sahayatri/features/notifications/presentation/view/notification_view.dart';
import 'package:sahayatri/features/vehicles/domain/entity/vehicle_entity.dart';
import 'package:sahayatri/features/vehicles/presentation/view/vehicle_view.dart';

class HomeState {
  final int index;
  final bool isLoading;
  final List<VehicleEntity> vehicles;
  final List<FavouriteEntity> favourites;
  final List<NotificationEntity> notifications;
  final List<Widget> lstWidgets;
  final int page;
  final bool hasReachedMax;

  HomeState( {required this.page,required this.hasReachedMax,required this.index, required this.lstWidgets, required this.isLoading, required this.vehicles, required this.favourites,required this.notifications});

  HomeState.initialState()
      : index = 0,
      page=0,
      hasReachedMax=false,      
        isLoading = false,
        vehicles = [],
        favourites = [],
        notifications = [],
        lstWidgets = [
          const VehicleView(),
          const FavouritesView(),
          const NotificationsView(),
          const ProfileView(),
        ];

  // CopyWith function to change the index no
  HomeState copyWith({
    int? index,
    bool? isLoading,
    List<VehicleEntity>? vehicles,
    List<FavouriteEntity>? favourites,
    List<NotificationEntity>? notifcations,

    bool? hasReachedMax,
    int? page
  }) {
    return HomeState(
      index: index ?? this.index,
      isLoading: isLoading ?? this.isLoading,
      vehicles: vehicles ?? this.vehicles,
      favourites: favourites ?? this.favourites,
      notifications: notifications,
      lstWidgets: lstWidgets,
      page: page?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}
