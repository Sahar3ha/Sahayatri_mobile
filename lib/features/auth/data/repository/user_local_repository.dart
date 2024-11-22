import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sahayatri/core/failure/failure.dart';
import 'package:sahayatri/features/auth/data/data_source/user_local_data_source.dart';
import 'package:sahayatri/features/auth/domain/entity/user_entity.dart';
import 'package:sahayatri/features/auth/domain/repository/user_repository.dart';

final userLocalRepositoryImplProvider = Provider.autoDispose<IUserRepository>(
    (ref) => UserLocalRepository(
        userLocalDataSource: ref.read(userLocalDataSourceProvider)));

class UserLocalRepository implements IUserRepository {
  final UserLocalDataSource userLocalDataSource;

  UserLocalRepository({required this.userLocalDataSource});

  @override
  Future<Either<Failure, bool>> registerUser(UserEntity user) {
    return userLocalDataSource.registerUser(user);
  }

  @override
  Future<Either<Failure, bool>> loginUser(String email, String password) {
    // TODO: implement loginUser
    throw UnimplementedError();
  }
}
