import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sahayatri/core/failure/failure.dart';
import 'package:sahayatri/features/notifications/data/repository/notification_remote_repository.dart';
import 'package:sahayatri/features/notifications/domain/entity/notification.dart';

final notificationRepositoryProvider =
    Provider.autoDispose<INotificationRepository>(
  (ref) {
    return ref.read(notificationRemoteRepositoryProvider);
  },
);

abstract class INotificationRepository {
  Future<Either<Failure, List<NotificationEntity>>> getNotifications(int page);
  Future<Either<Failure, bool>> clearNotification();
}
