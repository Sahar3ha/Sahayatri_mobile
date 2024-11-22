import 'package:json_annotation/json_annotation.dart';
import 'package:sahayatri/features/auth/domain/entity/user_entity.dart';
part 'user_api_model.g.dart';

@JsonSerializable()
class UserAPiModel {
  @JsonKey(name: '_id')
  final String? userId;
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  UserAPiModel(
      {this.userId,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.password});

  // factory UserAPiModel.fromJson(Map<String, dynamic> json) {
  //   return UserAPiModel(
  //       userId: json['_id'],
  //       firstName: json['firstName'],
  //       lastName: json['lastName'],
  //       email: json['email'],
  //       password: json['password']);
  // }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'firstName': firstName,
  //     'lastName': lastName,
  //     'email': email,
  //     'password': password
  //   };
  // }
  factory UserAPiModel.fromJson(Map<String, dynamic> json) =>
      _$UserAPiModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserAPiModelToJson(this);

  
  // From entity to model
  factory UserAPiModel.fromEntity(UserEntity user) {
    return UserAPiModel(
        userId: user.userId,
        firstName: user.firstName,
        lastName: user.lastName,
        email: user.email,
        password: user.password);
  }

  // From model to entity
  static UserEntity toEntity(UserAPiModel model) {
    return UserEntity(
      userId: model.userId,
      firstName: model.firstName,
      lastName: model.lastName,
      email: model.email,
      password: model.password,
    );
  }
}
