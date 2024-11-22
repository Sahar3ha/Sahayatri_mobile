import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sahayatri/config/constants/api_endpoints.dart';
import 'package:sahayatri/core/failure/failure.dart';
import 'package:sahayatri/core/networking/http_service.dart';
import 'package:sahayatri/core/shared_pref/user_shared_prefs.dart';
import 'package:sahayatri/features/auth/data/model/user_api_model.dart';
import 'package:sahayatri/features/auth/domain/entity/user_entity.dart';

final userRemoteDataSourceProvider =
    Provider.autoDispose<UserRemoteDataSource>((ref) {
  return UserRemoteDataSource(
    dio: ref.read(httpServiceProvider),
    userSharedPrefs: ref.read(userSharedPrefsProvider),
  );
});

class UserRemoteDataSource {
  final Dio dio;
  final UserSharedPrefs userSharedPrefs;

  UserRemoteDataSource({
    required this.dio,
    required this.userSharedPrefs,
  });

  Future<Either<Failure, bool>> loginUser(
    String email,
    String password,
  ) async {
    try {
      Response response = await dio.post(
        ApiEndpoints.login,
        data: {
          "email": email,
          "password": password,
        },
      );
      if (response.statusCode == 200) {
        String token = response.data["token"];
        await userSharedPrefs.setUserToken(token);
        await userSharedPrefs.setUser(response.data["userData"]);
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

  Future<Either<Failure, bool>> regsiterUser(UserEntity user) async {
    try {
      UserAPiModel userAPiModel = UserAPiModel.fromEntity(user);
      var response =
          await dio.post(ApiEndpoints.register, data: userAPiModel.toJson());
      if (response.statusCode == 201) {
        return const Right(true);
      } else {
        return Left(Failure(
            error: response.statusMessage.toString(),
            statusCode: response.statusCode.toString()));
      }
    } on DioException catch (e) {
      return Left(Failure(error: e.response?.data['message']));
    }
  }
}
