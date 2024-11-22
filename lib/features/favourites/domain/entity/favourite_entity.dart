import 'package:equatable/equatable.dart';

class FavouriteEntity extends Equatable {
  final String? id;
  final String? userId;
  final String vehicleId;

  const FavouriteEntity({this.id, this.userId, required this.vehicleId});

  @override
  List<Object?> get props => [id, userId, vehicleId];

  factory FavouriteEntity.fromJson(Map<String, dynamic> json) =>
      FavouriteEntity(
          id: json['id'], userId: json['userId'], vehicleId: json['vehicleId']['vehicleName']);

  Map<String, dynamic> toJson() =>
      {"id": id, "userId": userId, "vehicleId": vehicleId};

  FavouriteEntity copyWith({
    String? id,
    String? userId,
    String? vehicleId,
  }) {
    return FavouriteEntity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      vehicleId: vehicleId ?? this.vehicleId,
    );
  }

  @override
  String toString() {
    return 'FavouriteEntity(id: $id, userId: $userId, vehicleId: $vehicleId)';
  }
}
