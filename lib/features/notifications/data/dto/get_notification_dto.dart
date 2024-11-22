import 'package:json_annotation/json_annotation.dart';
import 'package:sahayatri/features/notifications/data/model/notification_api_model.dart';

part 'get_notification_dto.g.dart';

@JsonSerializable()
class GetNotificationDto {
  final bool success;
  @JsonKey(name: 'notification')
  final List<NotificationApiModel> data;

  GetNotificationDto(
      {required this.success, required this.data});

  factory GetNotificationDto.fromJson(Map<String, dynamic> json) =>
      _$GetNotificationDtoFromJson(json);
  Map<String, dynamic> toJson() => _$GetNotificationDtoToJson(this);
}
