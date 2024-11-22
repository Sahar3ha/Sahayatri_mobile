import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sahayatri/config/constants/api_endpoints.dart';
import 'package:sahayatri/core/failure/failure.dart';
import 'package:sahayatri/core/networking/http_service.dart';
import 'package:sahayatri/features/notifications/data/dto/get_notification_dto.dart';
import 'package:sahayatri/features/notifications/data/model/notification_api_model.dart';
import 'package:sahayatri/features/notifications/domain/entity/notification.dart';

final notificationRemoteDataSourceProvider =
    Provider<NotificationRemoteDataSource>((ref) {
  final dio = ref.read(httpServiceProvider);
  return NotificationRemoteDataSource(dio);
});

class NotificationRemoteDataSource {
  final Dio _dio;

  NotificationRemoteDataSource(this._dio);

  Future<Either<Failure, bool>> clearNotification() async {
    try {
      Response response = await _dio.delete(ApiEndpoints.deleteNotification);
      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(Failure(
          error: response.data["message"],
          statusCode: response.statusCode.toString(),
        ));
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

  Future<Either<Failure, List<NotificationEntity>>> getNotifications(
      int page) async {
    try {
      final response = await _dio.get(
        ApiEndpoints.notification,
        queryParameters: {
          '_page': page,
          '_limit': ApiEndpoints.limitPage,
        },
      );
      if (response.statusCode == 200) {
        GetNotificationDto getNotificationDto =
            GetNotificationDto.fromJson(response.data);
        List<NotificationEntity> notifications = getNotificationDto.data
            .map((data) => NotificationApiModel.toEntity(data))
            .toList();
        return Right(notifications);
      } else {
        return Left(Failure(
          error: response.statusMessage?.toString() ?? 'Unknown error',
          statusCode: response.statusCode.toString(),
        ));
      }
    } on DioException catch (e) {
      return Left(Failure(error: e.message.toString()));
    }
  }
}
