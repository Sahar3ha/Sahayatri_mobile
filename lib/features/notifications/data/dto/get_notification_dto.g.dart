// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_notification_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetNotificationDto _$GetNotificationDtoFromJson(Map<String, dynamic> json) =>
    GetNotificationDto(
      success: json['success'] as bool,
      data: (json['notification'] as List<dynamic>)
          .map((e) => NotificationApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetNotificationDtoToJson(GetNotificationDto instance) =>
    <String, dynamic>{
      'success': instance.success,
      'notification': instance.data,
    };
