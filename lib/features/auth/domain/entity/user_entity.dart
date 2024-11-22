import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? userId;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  

  const UserEntity({
    this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password
  });

  @override
  List<Object?> get props => [userId, firstName,lastName,email, password];
  factory UserEntity.fromJson(Map<String, dynamic> json) => UserEntity(
        userId: json["userId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        password: json["password"]
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "firstName": firstName,
        "lastName":lastName,
        "email":email,
        "password":password
      };

  @override
  String toString() {
    return 'UserEntity(userId: $userId, firstName: $firstName,lastName: $lastName,email: $email, password: $password)';
  }
}
