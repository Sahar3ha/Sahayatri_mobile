import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sahayatri/core/failure/failure.dart';
import 'package:sahayatri/features/feedback/data/repository/feedback_remote_repository.dart';
import 'package:sahayatri/features/feedback/domain/entity/feedback_entity.dart';

final feedbackRepositoryProvider = Provider.autoDispose<IFeedbackRepository>(
  (ref) => ref.read(feedbackRemoteRepositoryProvider),
);

abstract class IFeedbackRepository {
  Future<Either<Failure, bool>> addFeedback(FeedbackEntity feedbackEntity);
}
