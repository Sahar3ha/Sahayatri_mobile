// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_favourite_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetFavouriteDTO _$GetFavouriteDTOFromJson(Map<String, dynamic> json) =>
    GetFavouriteDTO(
      data: (json['favourites'] as List<dynamic>)
          .map((e) => FavouriteApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      success: json['success'] as bool,
    );

Map<String, dynamic> _$GetFavouriteDTOToJson(GetFavouriteDTO instance) =>
    <String, dynamic>{
      'success': instance.success,
      'favourites': instance.data,
    };
