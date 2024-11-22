import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sahayatri/core/failure/failure.dart';
import 'package:sahayatri/features/auth/domain/repository/user_repository.dart';

final userLoginUseCaseProvider = Provider.autoDispose<LoginUseCase>(
  (ref) => LoginUseCase(ref.watch(userRepositoryProvider)),
);

class LoginUseCase {
  final IUserRepository iUserRepository;
  LoginUseCase(this.iUserRepository);

  Future<Either<Failure, bool>> loginUser(String email, String password) async {
    return await iUserRepository.loginUser(email, password);
  }
}
