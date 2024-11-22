import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sahayatri/config/constants/api_endpoints.dart';
import 'package:sahayatri/core/failure/failure.dart';
import 'package:sahayatri/core/networking/http_service.dart';
import 'package:sahayatri/core/shared_pref/user_shared_prefs.dart';
import 'package:sahayatri/features/favourites/data/dto/get_favourite_dto.dart';
import 'package:sahayatri/features/favourites/data/model/favourite_api_model.dart';
import 'package:sahayatri/features/favourites/domain/entity/favourite_entity.dart';

final favouriteDataSourceProvider =
    Provider<FavouriteRemoteDataSource>((ref) => FavouriteRemoteDataSource(
          dio: ref.read(httpServiceProvider),
          userSharedPrefs: ref.read(userSharedPrefsProvider),
        ));

class FavouriteRemoteDataSource {
  final Dio dio;
  final UserSharedPrefs userSharedPrefs;

  FavouriteRemoteDataSource({
    required this.dio,
    required this.userSharedPrefs,
  });

  Future<Either<Failure, List<FavouriteEntity>>> getFavourite(int page) async {
    try {
      final userData = await userSharedPrefs.getUser();
      if (userData == null || userData['_id'] == null) {
        return Left(Failure(error: 'User data or user ID is null'));
      }

      String id = userData['_id'].toString();
      final url = 'users/get_favourite/$id';
      final response = await dio.get(url, queryParameters: {
        '_page': page,
        '_limit': ApiEndpoints.limitPage,
      });
      if (response.statusCode == 200) {
        GetFavouriteDTO getFavouriteDTO =
            GetFavouriteDTO.fromJson(response.data);
        List<FavouriteEntity> favouriteList = getFavouriteDTO.data
            .map((data) => FavouriteApiModel.toEntity(data))
            .toList();
        return Right(favouriteList);
      } else {
        return Left(Failure(
          error: response.statusMessage?.toString() ?? 'Unknown Error',
          statusCode: response.statusCode.toString(),
        ));
      }
    } on DioException catch (e) {
      return Left(Failure(error: e.message.toString()));
    }
  }

  Future<Either<Failure, bool>> deleteFavourite(
      FavouriteEntity favouriteEntity) async {
    try {
      final userTokenEither = await UserSharedPrefs().getUserToken();
      if (userTokenEither.isLeft()) {
        // Handle the failure to get the user token
        return left(userTokenEither.fold(
            (failure) => failure, (_) => Failure(error: '')));
      }

      final userToken = userTokenEither.getOrElse(() => null);

      final response = await dio.delete(
          ApiEndpoints.deleteFavourite + favouriteEntity.id!,
          options: Options(headers: {'Authorization': 'Bearer $userToken'}));

      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(Failure(
          error: response.data["message"],
          statusCode: response.statusCode.toString(),
        ));
      }
    } on DioException catch (e) {
      return Left(Failure(
        error: 'Failed to add feedback: ${e.toString()}',
      ));
    }
  }

  Future<Either<Failure, bool>> addFavourite(
      FavouriteEntity favouriteEntity) async {
    try {
      final userData = await userSharedPrefs.getUser();
      if (userData == null || userData['_id'] == null) {
        return Left(Failure(error: 'User data or user ID is null'));
      }

      String id = userData['_id'].toString();
      FavouriteApiModel favouriteApiModel =
          FavouriteApiModel.fromEntity(favouriteEntity.copyWith(userId: id));

      var response = await dio.post(
        ApiEndpoints.addFavourites,
        data: favouriteApiModel.toJson(),
      );
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
