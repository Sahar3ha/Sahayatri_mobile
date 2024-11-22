import 'package:json_annotation/json_annotation.dart';
import 'package:sahayatri/features/vehicles/data/model/vehicle_api_model.dart';

part 'get_all_vehicles_dto.g.dart';

@JsonSerializable()
class GetAllVehicleDTO {
  final bool success;
  @JsonKey(name: 'vehicles')
  final List<VehicleAPIModel> data;

  GetAllVehicleDTO(
      {required this.success, required this.data});

  factory GetAllVehicleDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllVehicleDTOFromJson(json);
  Map<String, dynamic> toJson() => _$GetAllVehicleDTOToJson(this);
}
