import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sahayatri/core/failure/failure.dart';
import 'package:sahayatri/features/feedback/data/data_source/feedback_remote_data_source.dart';
import 'package:sahayatri/features/feedback/domain/entity/feedback_entity.dart';
import 'package:sahayatri/features/feedback/domain/repository/feedback_repository.dart';

final feedbackRemoteRepositoryProvider =
    Provider.autoDispose<IFeedbackRepository>(
  (ref) => FeedbackRemoteRepoImpl(
      feedbackRemoteDataSource: ref.read(feedbackRemoteDataSourceProvider)),
);

class FeedbackRemoteRepoImpl implements IFeedbackRepository {
  final FeedbackRemoteDataSource feedbackRemoteDataSource;

  FeedbackRemoteRepoImpl({required this.feedbackRemoteDataSource});

  @override
  Future<Either<Failure, bool>> addFeedback(FeedbackEntity feedbackEntity) {
    return feedbackRemoteDataSource.addFeedback(feedbackEntity);
  }
}
