
import 'package:json_annotation/json_annotation.dart';
import 'package:sahayatri/features/vehicles/domain/entity/vehicle_entity.dart';

@JsonSerializable()
class VehicleAPIModel {
  @JsonKey(name: '_id')
  final String? vehicleId;
  final String vehicleName;
  final String from;
  final String to;


  VehicleAPIModel({this.vehicleId, required this.vehicleName,required this.from,required this.to});

  // To Json and fromJson without freezed
  factory VehicleAPIModel.fromJson(Map<String, dynamic> json) {
    return VehicleAPIModel(
      vehicleId: json['_id'],
      vehicleName: json['vehicleName'],
      from: json['from'],
      to: json['to']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'vehicleName': vehicleName,
      'from':from,
      'to':to
    };
  }

  // From entity to model
  factory VehicleAPIModel.fromEntity(VehicleEntity entity) {
    return VehicleAPIModel(
      vehicleId: entity.vehicleId,
      vehicleName: entity.vehicleName,
      from: entity.from,
      to: entity.to
    );
  }

  // From model to entity
  static VehicleEntity toEntity(VehicleAPIModel model) {
    return VehicleEntity(
      vehicleId: model.vehicleId,
      vehicleName: model.vehicleName,
      from: model.from,
      to: model.to
    );
  }
}
