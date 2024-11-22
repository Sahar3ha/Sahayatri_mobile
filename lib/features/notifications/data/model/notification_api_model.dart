import 'package:json_annotation/json_annotation.dart';
import 'package:sahayatri/features/notifications/domain/entity/notification.dart';

@JsonSerializable()
class NotificationApiModel {
  @JsonKey(name: '_id')
  final String? notificationId;
  final String vehicleId;

  NotificationApiModel({this.notificationId, required this.vehicleId});

  factory NotificationApiModel.fromJson(Map<String, dynamic> json) {
    return NotificationApiModel(
        notificationId: json['_id'], vehicleId: json['vehicleId']['vehicleName']);
  }

  Map<String, dynamic> toJson() {
    return {
      'vehicleId': vehicleId};
  }

  factory NotificationApiModel.fromEntity(
      NotificationEntity notificationEntity) {
    return NotificationApiModel(vehicleId: notificationEntity.vehicleId);
  }

  static NotificationEntity toEntity(NotificationApiModel model) {
    return NotificationEntity(
      notificationId:model.notificationId,
      vehicleId: model.vehicleId
    );
  }
}
