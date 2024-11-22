import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sahayatri/features/notifications/domain/use_case/get_notification_use_case.dart';
import 'package:sahayatri/features/notifications/presentation/state/notification_state.dart';

final getFavouritesViewModelProvider =
    StateNotifierProvider<NotificationViewModel, NotificationState>((ref) {
  final getnotification = ref.read(getNotificationUseCaseProvider);
  return NotificationViewModel(getnotification);
});

class NotificationViewModel extends StateNotifier<NotificationState> {
  final GetNotificationUseCase _getNotificationUseCase;
  NotificationViewModel(
    this._getNotificationUseCase,
  ) : super(
          NotificationState.initial(),
        ) {
    getNotifications();
  }

  Future resetState() async {
    state = NotificationState.initial();
    getNotifications();
  }

  Future<void> clearNotifications() async {
    try {
      await _getNotificationUseCase.clearNotification();
      state = state.copyWith(notifications: [], isLoading: false);
    } catch (error) {
      print(error.toString());
    }
  }

  Future getNotifications() async {
    state = state.copyWith(isLoading: true);
    final currentState = state;
    final page = currentState.page + 1;
    final notifications = currentState.notifications;
    final hasReachedMax = currentState.hasReachedMax;
    if (!hasReachedMax) {
      // get data from data source
      final result = await _getNotificationUseCase.getNotifications(page);
      result.fold(
        (failure) =>
            state = state.copyWith(hasReachedMax: true, isLoading: false),
        (data) {
          if (data.isEmpty) {
            state = state.copyWith(hasReachedMax: true);
          } else {
            state = state.copyWith(
              notifications: [...notifications, ...data],
              page: page,
              isLoading: false,
            );
          }
        },
      );
    }
  }
}
