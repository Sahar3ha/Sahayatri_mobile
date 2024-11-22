import 'package:equatable/equatable.dart';

class NotificationEntity extends Equatable {
  final String? notificationId;
  final String vehicleId;
  const NotificationEntity({
    this.notificationId,
    required this.vehicleId});

  @override
  List<Object?> get props => [vehicleId];

  factory NotificationEntity.fromnJson(Map<String, dynamic> json) =>
      NotificationEntity(
        notificationId: json["notificationId"],
        vehicleId: json["vehicleId"]['vehicleName']
        );

  Map<String, dynamic> toJson() => {
    "notificationId":notificationId,
    "vehicleId": vehicleId
    };

  @override
  String toString() {
    return 'NotificationEntity(notificationId:$notificationId,vehicleId:$vehicleId)';
  }
}
