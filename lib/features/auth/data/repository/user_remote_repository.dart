import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sahayatri/core/failure/failure.dart';
import 'package:sahayatri/features/auth/data/data_source/user_remote_data_source.dart';
import 'package:sahayatri/features/auth/domain/entity/user_entity.dart';
import 'package:sahayatri/features/auth/domain/repository/user_repository.dart';

final userRemoteRepositoryProvider = Provider.autoDispose<IUserRepository>(
  (ref)=> UserRemoteRepoImpl(
    userRemoteDataSource: ref.read(userRemoteDataSourceProvider))
);

class UserRemoteRepoImpl implements IUserRepository {
  final UserRemoteDataSource userRemoteDataSource;

  UserRemoteRepoImpl({required this.userRemoteDataSource});

  @override
  Future<Either<Failure, bool>> registerUser(UserEntity user) {
    return userRemoteDataSource.regsiterUser(user);
  }

  @override
  Future<Either<Failure, bool>> loginUser(String email, String password) async {
    return await userRemoteDataSource.loginUser(email, password);
  }
}
