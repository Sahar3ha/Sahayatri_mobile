import 'package:json_annotation/json_annotation.dart';
import 'package:sahayatri/features/favourites/domain/entity/favourite_entity.dart';

// part 'favourite_api_model.g.dart';

@JsonSerializable()
class FavouriteApiModel {
  @JsonKey(name: '_id')
  final String? id;
  final String? userId;
  final String vehicleId ;

  FavouriteApiModel({this.id, this.userId, required this.vehicleId});

  factory FavouriteApiModel.fromJson(Map<String, dynamic> json) {
    return FavouriteApiModel(
        id: json['_id'], 
        userId: json['userId'], 
        vehicleId: json['vehicleId']['vehicleName']
        );
  }
Map<String, dynamic> toJson() {
    return {
      'userId': userId, 
      'vehicleId': vehicleId
    };
  }

  // factory FavouriteApiModel.fromJson(Map<String, dynamic> json) =>
  //     _$FavouriteApiModelFromJson(json);
  
  // Map<String, dynamic> toJson() => _$FavouriteApiModelToJson(this);


  factory FavouriteApiModel.fromEntity(FavouriteEntity favouriteEntity) {
    return FavouriteApiModel(
        id: favouriteEntity.id,
        userId: favouriteEntity.userId, 
        vehicleId: favouriteEntity.vehicleId);
  }
  static FavouriteEntity toEntity(FavouriteApiModel model) {
    return FavouriteEntity(
        id: model.id, userId: model.userId, vehicleId: model.vehicleId);
  }
}
