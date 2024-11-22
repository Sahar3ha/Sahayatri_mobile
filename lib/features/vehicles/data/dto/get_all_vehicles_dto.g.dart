// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_vehicles_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllVehicleDTO _$GetAllVehicleDTOFromJson(Map<String, dynamic> json) =>
    GetAllVehicleDTO(
      success: json['success'] as bool,
      data: (json['vehicles'] as List<dynamic>)
          .map((e) => VehicleAPIModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllVehicleDTOToJson(GetAllVehicleDTO instance) =>
    <String, dynamic>{
      'success': instance.success,
      'vehicles': instance.data,
    };
