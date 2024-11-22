import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sahayatri/core/failure/failure.dart';
import 'package:sahayatri/features/notifications/data/data_source/notification_remote_data_source.dart';
import 'package:sahayatri/features/notifications/domain/entity/notification.dart';
import 'package:sahayatri/features/notifications/domain/repository/notification_repository.dart';

final notificationRemoteRepositoryProvider =
    Provider.autoDispose<INotificationRepository>((ref) =>
        NotificationRemoteRepoImpl(
            notificationRemoteDataSource:
                ref.read(notificationRemoteDataSourceProvider)));

class NotificationRemoteRepoImpl implements INotificationRepository {
  final NotificationRemoteDataSource notificationRemoteDataSource;

  const NotificationRemoteRepoImpl(
      {required this.notificationRemoteDataSource});

  @override
  Future<Either<Failure, List<NotificationEntity>>> getNotifications(int page) {
    return notificationRemoteDataSource.getNotifications(page);
  }

  @override
  Future<Either<Failure, bool>> clearNotification() {
    return notificationRemoteDataSource.clearNotification();
  }
}
