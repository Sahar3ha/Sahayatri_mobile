import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sahayatri/core/failure/failure.dart';
import 'package:sahayatri/features/notifications/domain/entity/notification.dart';
import 'package:sahayatri/features/notifications/domain/repository/notification_repository.dart';

final getNotificationUseCaseProvider =
    Provider.autoDispose<GetNotificationUseCase>(
  (ref) => GetNotificationUseCase(
      repository: ref.read(notificationRepositoryProvider)),
);

class GetNotificationUseCase {
  final INotificationRepository repository;

  GetNotificationUseCase({required this.repository});

  Future<Either<Failure, List<NotificationEntity>>> getNotifications(int page) async {
    return await repository.getNotifications(page);
  }
  
  Future<Either<Failure, bool>> clearNotification()async{
      return await repository.clearNotification();
   }

}
