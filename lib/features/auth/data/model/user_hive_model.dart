import 'package:hive_flutter/hive_flutter.dart';
import 'package:sahayatri/config/constants/hive_table_constant.dart';
import 'package:sahayatri/features/auth/domain/entity/user_entity.dart';

import 'package:uuid/uuid.dart';

part 'user_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.userTableId)
class UserHiveModel {
  @HiveField(0)
  final String userId;

  @HiveField(1)
  final String firstName;

  @HiveField(2)
  final String lastName;

  @HiveField(3)
  final String email;

  @HiveField(4)
  final String password;

  // Constructor
  UserHiveModel({
    String? userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  }) : userId = userId ?? const Uuid().v4();

  // empty constructor
  UserHiveModel.empty()
      : this(
          userId: '',
          firstName: '',
          lastName: '',
          email: '',
          password: '',
        );

  // Convert Hive Object to Entity
  static UserEntity toEntity(UserHiveModel hiveModel) => UserEntity(
      userId: hiveModel.userId,
      firstName: hiveModel.firstName,
      lastName: hiveModel.lastName,
      email: hiveModel.email,
      password: hiveModel.password);

  // Convert Entity to Hive Object
  factory UserHiveModel.toHiveModel(UserEntity entity) => UserHiveModel(
      // batchId: entity.batchId,
      firstName: entity.firstName,
      lastName: entity.lastName,
      email: entity.email,
      password: entity.password);

  @override
  String toString() {
    return 'userId: $userId,  firstName: $firstName,lastName: $lastName,email: $email, password: $password';
  }
}
