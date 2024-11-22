import 'package:equatable/equatable.dart';

class VehicleEntity extends Equatable {
  final String? vehicleId;
  final String vehicleName;
  final String from;
  final String to;

  const VehicleEntity(
      {this.vehicleId,
      required this.vehicleName,
      required this.from,
      required this.to});

  @override
  List<Object?> get props => [vehicleId, vehicleName, from, to];

  
  factory VehicleEntity.fromJson(Map<String, dynamic> json) => VehicleEntity(
      vehicleId: json["vehicleId"],
      vehicleName: json["vehicleName"],
      from: json["from"],
      to: json["to"]);

  Map<String, dynamic> toJson() => {
        "vehicleId": vehicleId,
        "vehicleName": vehicleName,
        "from": from,
        "to": to
      };

  @override
  String toString() {
    return 'VehicleEntity(vehicleId: $vehicleId, vehicleName: $vehicleName, from: $from,to: $to)';
  }
}
