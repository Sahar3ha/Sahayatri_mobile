import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sahayatri/config/constants/api_endpoints.dart';
import 'package:sahayatri/core/failure/failure.dart';
import 'package:sahayatri/core/networking/http_service.dart';
import 'package:sahayatri/core/shared_pref/user_shared_prefs.dart';
import 'package:sahayatri/features/feedback/data/model/feedback_api_model.dart';
import 'package:sahayatri/features/feedback/domain/entity/feedback_entity.dart';

final feedbackRemoteDataSourceProvider =
    Provider.autoDispose<FeedbackRemoteDataSource>((ref) {
  return FeedbackRemoteDataSource(
    dio: ref.read(httpServiceProvider),
    userSharedPrefs: ref.read(userSharedPrefsProvider),
  );
});

class FeedbackRemoteDataSource {
  final Dio dio;
  final UserSharedPrefs userSharedPrefs;

  FeedbackRemoteDataSource({
    required this.dio,
    required this.userSharedPrefs,
  });

  Future<Either<Failure, bool>> addFeedback(
    FeedbackEntity feedbackEntity,
  ) async {
    try { 
      // Retrieve user token from SharedPreferences
      final userTokenEither = await UserSharedPrefs().getUserToken();
      if (userTokenEither.isLeft()) {
        // Handle the failure to get the user token
        return left(userTokenEither.fold(
            (failure) => failure, (_) => Failure(error: '')));
      }

      final userToken = userTokenEither.getOrElse(() => null);
      
      final feedbackApiModel = FeedbackApiModel.fromEntity(feedbackEntity);

      final response = await dio.post(ApiEndpoints.addFeedback+feedbackEntity.vehicleId!,
          data: feedbackApiModel.toJson(),
          options: Options(headers: {'Authorization': 'Bearer $userToken'}));
     

      if (response.statusCode == 201) {
        return const Right(true);
      } else {
        return Left(Failure(
          error: 'Failed to add feedback',
          statusCode: response.statusCode.toString(),
        ));
      }
    } on DioException catch (e) {
      return Left(Failure(
        error: 'Failed to add feedback: ${e.toString()}',
      ));
    }
  }
}
