import 'package:sahayatri/features/notifications/domain/entity/notification.dart';

class NotificationState {
  final bool isLoading;
  final List<NotificationEntity> notifications;
  final int page;
  final bool hasReachedMax;

  NotificationState({
    required this.isLoading,
    required this.notifications,
    required this.page,
    required this.hasReachedMax
  });

  factory NotificationState.initial() {
    return NotificationState(
      isLoading: false,
      notifications: [],
      hasReachedMax: false,
      page: 0
    );
  }

  NotificationState copyWith({
    bool? isLoading,
    List<NotificationEntity>? notifications,
    bool? hasReachedMax,
    int? page
  }) {
    return NotificationState(
      isLoading: isLoading ?? this.isLoading,
      notifications: notifications ?? this.notifications,
      page: page?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}
