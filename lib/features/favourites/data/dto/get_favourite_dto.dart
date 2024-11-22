import 'package:json_annotation/json_annotation.dart';
import 'package:sahayatri/features/favourites/data/model/favourite_api_model.dart';

part 'get_favourite_dto.g.dart';

@JsonSerializable()
class GetFavouriteDTO {
  final bool success;
  @JsonKey(name: 'favourites')
  final List<FavouriteApiModel> data;

  GetFavouriteDTO({required this.data, required this.success});

  factory GetFavouriteDTO.fromJson(Map<String, dynamic> json) =>
      _$GetFavouriteDTOFromJson(json);
  Map<String, dynamic> toJson() => _$GetFavouriteDTOToJson(this);
}
