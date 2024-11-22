import 'package:dartz/dartz.dart';
import 'package:sahayatri/core/failure/failure.dart';
import 'package:sahayatri/features/notifications/domain/repository/notification_repository.dart';

class ClearNotification {
  final INotificationRepository repository;
  ClearNotification({required this.repository});

  Future<Either<Failure, bool>> clearNotification() async {
    return await repository.clearNotification();
  }
}
