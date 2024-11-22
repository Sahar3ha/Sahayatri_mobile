import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sahayatri/core/failure/failure.dart';
import 'package:sahayatri/features/feedback/domain/entity/feedback_entity.dart';
import 'package:sahayatri/features/feedback/domain/repository/feedback_repository.dart';

final addFeedbackUseCaseProvider = Provider.autoDispose<AddFeedbackUseCase>(
    (ref) =>
        AddFeedbackUseCase(repository: ref.read(feedbackRepositoryProvider)));

class AddFeedbackUseCase {
  final IFeedbackRepository repository;

  AddFeedbackUseCase({required this.repository});

  Future<Either<Failure, bool>> addFeedback(
      FeedbackEntity feedbackEntity) async {
    return await repository.addFeedback(feedbackEntity);
  }
}
